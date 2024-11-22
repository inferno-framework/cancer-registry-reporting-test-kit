require_relative 'fixtures/dummy_ms_test'
RSpec.describe CancerRegistryReportingTestKit::MustSupportTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('ccrr_hdea') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  
  
  let(:bundle) do
    bundle_file = File.read('spec/fixtures/ccrr_hdea_content_bundle_example_with_multiple_resource_type_section.json')
    bundle_model = FHIR.from_contents(bundle_file)
  end


  before do
    # Dynamically add the test to the suite
    suite.groups.first.test CancerRegistryReportingTestKit::HDEAV100::DummyMustSupportTest.new
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
    let(:dummy_must_support_test) { CancerRegistryReportingTestKit::HDEAV100::TestMustSupportTest}

    it 'passes if server suports all MS extensions' do
      binding.pry
      result = run(dummy_must_support_test)
      expect(result.result).to eq('pass')
    end
  end
end


  