RSpec.describe CancerRegistryReportingTestKit::HDEAV100::CcrrContentBundleValidationTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('ccrr_v100_report_generation') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_scratch) { {} }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }

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
    let(:validation_test) { suite.groups.first.test(from: :ccrr_v100_ccrr_content_bundle_validation_test) }
    let(:incomplete_bundle) { File.read('spec/fixtures/ccrr_hdea_content_bundle_example_incomplete.json') }
    let(:complete_bundle) { File.read('spec/fixtures/ccrr_hdea_content_bundle_example_complete.json')}
    let(:validation_ok_response) { File.read('spec/fixtures/validation_ok.json')}

    it 'stores all resources in scratch when given multiple input reports' do
      allow_any_instance_of(validation_test).to receive(:scratch).and_return(test_scratch)
      stub_request(:post, "https://example.com/validatorapi/validate").to_return(status: 200, body: validation_ok_response, headers: { 'Content-Type' => 'application/fhir+json' })
      result = run(validation_test, {reports: incomplete_bundle + ',' + complete_bundle})
      patient_ids = test_scratch[:patient_resources][:all].map { |resource| resource.id}
      expect(patient_ids).to eq(["example-incomplete-Patient", "example-complete-Patient"])
    end
  end
end


  