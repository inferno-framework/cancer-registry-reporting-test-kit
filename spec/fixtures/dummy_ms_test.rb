# frozen_string_literal: true

require_relative '../../lib/cancer_registry_reporting_test_kit/must_support_test'
require_relative '../../lib/cancer_registry_reporting_test_kit/bundle_parse'

module CancerRegistryReportingTestKit
  module HDEAV100
    class DummyMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest
      include CancerRegistryReportingTestKit::HDEABundleParse

      title 'Parsing a Bundle'
      description %(
        This is a dummy wrapper to test the parse_bundle method. It asserts no
        missed references, and returned resources

      )

      id :ccrr_v100_dummy_must_support_test

      input :input_bundle


      def init_scratch
        scratch ||= {}
      end

      run do
        report_results, missed_references = parse_bundle(FHIR.from_contents(input_bundle), 1)
        assert report_results, 'No resources resolved or found'
        assert missed_references.empty?, "Reference Missed: #{missed_references}"
      end
    end
  end
end
