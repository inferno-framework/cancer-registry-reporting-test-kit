require_relative '../../must_support_test'
require_relative '../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CentralCancerRegistryPrimaryCancerConditionMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Primary Cancer Condition resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.Condition
        * Condition.abatementDateTime
        * Condition.bodySite
        * Condition.bodySite.extension
        * Condition.bodySite.extension:data-absent-reason
        * Condition.bodySite.extension:lateralityQualifier
        * Condition.bodySite.extension:locationQualifier
        * Condition.category
        * Condition.category:sdoh
        * Condition.category:us-core
        * Condition.clinicalStatus
        * Condition.code
        * Condition.extension
        * Condition.extension:assertedDate
        * Condition.extension:histologyMorphologyBehavior
        * Condition.extension:mcode-cancer-disease-type-evidence-type
        * Condition.onsetDateTime
        * Condition.recordedDate
        * Condition.stage
        * Condition.stage.assessment
        * Condition.subject
        * Condition.verificationStatus
      )

      id :ccrr_v100_central_cancer_registry_primary_cancer_condition_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', '..', 'generated', 'v1.0.0', 'central_cancer_registry_primary_cancer_condition', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:central_cancer_registry_primary_cancer_condition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
