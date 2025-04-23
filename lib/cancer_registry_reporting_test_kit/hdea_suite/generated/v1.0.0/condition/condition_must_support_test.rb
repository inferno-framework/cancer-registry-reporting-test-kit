# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class ConditionMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'US Core Condition profile must support element coverage'
      description %(
        This test looks across all instances
        associated with the [US Core Condition profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition|3.1.1)
        found in the provided report Bundles and verifies that they
        contain populated examples of the following must support elements
        defined in the profile:

        * Condition.category
        * Condition.clinicalStatus
        * Condition.code
        * Condition.subject
        * Condition.verificationStatus
      )

      id :ccrr_v100_condition_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
