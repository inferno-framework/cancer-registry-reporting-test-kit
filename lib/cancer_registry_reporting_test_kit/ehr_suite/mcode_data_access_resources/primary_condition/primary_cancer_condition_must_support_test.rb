# frozen_string_literal: true

require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class PrimaryCancerConditionMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the mCODE Primary Cancer Condition resources returned'
    description %(
      CCRR EHRs SHALL be capable of populating all data elements as
      part of the query results. This test will look through the Condition resources
      found previously for the following must support elements:

      * Condition.abatement[x]
      * Condition.bodySite
      * Condition.bodySite.extension:locationQualifier
      * Condition.bodySite.extension:lateralityQualifier
      * Condition.category
      * Condition.code
      * Condition.clinicalStatus
      * Condition.extension:assertedDate
      * Condition.extension:histologyMorphologyBehavior
      * Condition.verificationStatus
      * Condition.recordedDate
      * Condition.onset[x]
      * Condition.subject
      * Condition.stage
      * Condition.stage.assessment
    )

    id :ccrr_primary_cancer_condition_must_support_test

    def resource_type
      'Condition'
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:primary_condition_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
