require_relative 'fixtures/dummy_ms_test'
RSpec.describe CancerRegistryReportingTestKit::MustSupportTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('ccrr_v100_report_generation') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }


  before do
    suite.test.repository.insert(CancerRegistryReportingTestKit::HDEAV100::DummyMustSupportTest)
    suite.groups.first.test(from: 'ccrr_v100_dummy_must_support_test'.to_sym)
  end

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name: name,
        value: value,
        type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session: test_session, test_run: test_run).run(runnable)
  end
  
  describe 'bundle_parse' do
    let(:dummy_must_support_test) { CancerRegistryReportingTestKit::HDEAV100::DummyMustSupportTest}
    let(:incomplete_bundle) { File.read('spec/fixtures/ccrr_hdea_content_bundle_example_incomplete.json') }
    let(:complete_bundle) { File.read('spec/fixtures/ccrr_hdea_content_bundle_example_complete.json')}

    it 'returns unresolved references if report contains any' do
      result = run(dummy_must_support_test, {input_bundle: incomplete_bundle})
      expect(result.result).to eq("fail") 
      expect(result.result_message).to eq('Reference Missed: ["Observation/tnm-clinical-stage-group-jenny-m"]')
    end

    it 'reports no unresolved references if report does not contain any' do
      result = run(dummy_must_support_test, {input_bundle: complete_bundle})
      expect(result.result).to eq("pass") 
    end

    it 'does not convolute missing references from different calls' do
      result = run(dummy_must_support_test, {input_bundle: incomplete_bundle})
      expect(result.result).to eq("fail") 
      expect(result.result_message).to eq('Reference Missed: ["Observation/tnm-clinical-stage-group-jenny-m"]')

      result = run(dummy_must_support_test, {input_bundle: complete_bundle})
      expect(result.result).to eq("pass") 
    end
  end
end


  