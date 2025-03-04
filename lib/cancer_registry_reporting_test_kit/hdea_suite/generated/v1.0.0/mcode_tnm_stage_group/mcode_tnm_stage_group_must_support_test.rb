# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class McodeTnmStageGroupMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Mcode Tnm Stage Group resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.code
        * Observation.effective[x]
        * Observation.focus
        * Observation.hasMember
        * Observation.method
        * Observation.status
        * Observation.subject
        * Observation.value[x]
      )

      id :ccrr_v100_mcode_tnm_stage_group_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:mcode_tnm_stage_group_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
