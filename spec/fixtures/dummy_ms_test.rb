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
        report_results = parse_bundle(bundle_model)
        binding.pry
      end
    end
  end
end
