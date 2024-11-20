require_relative '../../must_support_test'
require_relative '../../bundle_parse'

module CancerRegistryReportingTestKit
  module HDEAV100
    class TestMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest
      include CancerRegistryReportingTestKit::HDEABundleParse

      title 'Parsing a Bundle'
      description %(
        test

      )

      id :ccrr_v100_test_must_support_test

      run do
        bundle = File.read('spec/fixtures/ccrr_hdea_content_bundle_example_with_multiple_resource_type_section.json')
        bundle_model = FHIR.from_contents(bundle)
        report_results = parse_bundle(bundle_model)
        report_results.each { |k,v| info "#{k} ---> #{v&.to_s}\n\n"}
      end
    end
  end
end
