RSpec.describe CancerRegistryReportingTestKit::HDEAV100::CcrrContentBundleValidationTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('ccrr_v100_report_generation') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name: name,
        value: value,
        type: 'text' # edited for this kit
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
      # validation_test_instance = validation_test.new TODO: figure out if better to use instance or class -- `run` method needs class, but if instance could access scratch?
      stub_request(:post, "https://example.com/validatorapi/validate").to_return(status: 200, body: validation_ok_response, headers: { 'Content-Type' => 'application/fhir+json' })
      result = run(validation_test, {reports: incomplete_bundle})
      # resources = validation_test_instance.scratch_resources[:all] TODO: fails, even when an instance -- does not seem to be able to find `scratch` from the main session, but can respond to scratch_resources
      #TODO: Figure out how to access scratch from within rspec
      #TODO: Access scratch after running validation test to see if resources from both reports were read in -- also need to make two small distinct reports to test this with.
    end
  end
end


  