require_relative '../../lib/cancer_registry_reporting_test_kit/must_support_test'
require_relative '../../lib/cancer_registry_reporting_test_kit/bundle_parse'

module CancerRegistryReportingTestKit
  module HDEAV100
    class DummyMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest
      include CancerRegistryReportingTestKit::HDEABundleParse

      title 'Parsing a Bundle'
      description %(
        test

      )

      id :ccrr_v100_dummy_must_support_test

      run do
        bundle_file = File.read('spec/fixtures/ccrr_hdea_content_bundle_example_with_multiple_resource_type_section.json')
        bundle_model = FHIR.from_contents(bundle_file)
        report_results = parse_bundle(bundle_model)
      end
    end
  end
end
