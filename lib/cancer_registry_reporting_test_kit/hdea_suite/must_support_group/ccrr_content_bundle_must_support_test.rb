require_relative '../../must_support_test'
require pry


module CancerRegistryReportingTestKit
  module HDEAV100
    class CcrrContentBundleMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Bundle resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry:composition
        * Bundle.entry:composition.resource
      )

      # This is the first test where we loop through all of the bundles and on each bundles we are calling (bundles_parse())
      # scratch = { all: { profile1: ['resource1'], profile2: ['resource2'] } }
      def ms_scratch
        scratch[:all] ||= {}
      end

      reports.each do |bundle|
        report_hash = parse_bundle(bundle)
        ms_scratch.merge(report_hash) {|profile, ms_resources_scratch, report_hash_resources| ms_resources_scratch << report_hash_resources}
      end

      

      # pass to each test the ms_scratch for each one 
      # check to see that all resources are merged correctly with the binding.pry 
      binding.pry 

      id :ccrr_v100_ccrr_content_bundle_must_support_test

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:ccrr_content_bundle_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
