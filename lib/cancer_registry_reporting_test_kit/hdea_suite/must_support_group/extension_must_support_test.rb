require_relative '../../must_support_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class ExtensionMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Extension resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Extension resources
        found previously for the following must support elements:

        * Extension.extension:EnrolledTribeMember
        * Extension.extension:TribeName
      )

      id :ccrr_v100_extension_must_support_test

      def resource_type
        'Extension'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:extension_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
