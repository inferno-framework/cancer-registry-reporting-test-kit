require_relative '../../../must_support_test'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class McodeTnmPrimaryTumorCategoryMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Mcode Tnm Primary Tumor Category resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.code
        * Observation.effective[x]
        * Observation.focus
        * Observation.method
        * Observation.status
        * Observation.subject
        * Observation.value[x]
      )

      id :ccrr_v100_mcode_tnm_primary_tumor_category_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:mcode_tnm_primary_tumor_category_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
