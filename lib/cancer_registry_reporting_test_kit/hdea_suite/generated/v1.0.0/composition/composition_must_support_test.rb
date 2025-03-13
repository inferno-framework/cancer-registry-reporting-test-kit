# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CompositionMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the CCRR Composition resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Composition resources
        found previously for the following must support elements:

        * Composition.Composition
        * Composition.author
        * Composition.date
        * Composition.encounter
        * Composition.identifier
        * Composition.section
        * Composition.section:sliceAllergiesSection
        * Composition.section:sliceAllergiesSection.code
        * Composition.section:sliceAllergiesSection.entry
        * Composition.section:sliceAllergiesSection.text
        * Composition.section:sliceCancerStageGroup
        * Composition.section:sliceCancerStageGroup.code
        * Composition.section:sliceCancerStageGroup.entry
        * Composition.section:sliceCancerStageGroup.text
        * Composition.section:sliceMedicationsAdministeredSection
        * Composition.section:sliceMedicationsAdministeredSection.code
        * Composition.section:sliceMedicationsAdministeredSection.entry
        * Composition.section:sliceMedicationsAdministeredSection.text
        * Composition.section:sliceMedicationsSection
        * Composition.section:sliceMedicationsSection.code
        * Composition.section:sliceMedicationsSection.entry
        * Composition.section:sliceMedicationsSection.text
        * Composition.section:sliceNotesSection
        * Composition.section:sliceNotesSection.code
        * Composition.section:sliceNotesSection.entry
        * Composition.section:sliceNotesSection.text
        * Composition.section:sliceOdhSection
        * Composition.section:sliceOdhSection.code
        * Composition.section:sliceOdhSection.entry
        * Composition.section:sliceOdhSection.text
        * Composition.section:slicePlanOfTreatmentSection
        * Composition.section:slicePlanOfTreatmentSection.code
        * Composition.section:slicePlanOfTreatmentSection.entry
        * Composition.section:slicePlanOfTreatmentSection.text
        * Composition.section:slicePrimaryCancerCondition
        * Composition.section:slicePrimaryCancerCondition.code
        * Composition.section:slicePrimaryCancerCondition.entry
        * Composition.section:slicePrimaryCancerCondition.text
        * Composition.section:sliceProblemSection
        * Composition.section:sliceProblemSection.code
        * Composition.section:sliceProblemSection.entry
        * Composition.section:sliceProblemSection.text
        * Composition.section:sliceProceduresSection
        * Composition.section:sliceProceduresSection.code
        * Composition.section:sliceProceduresSection.entry
        * Composition.section:sliceProceduresSection.text
        * Composition.section:sliceRadioTherapyCourseSummary
        * Composition.section:sliceRadioTherapyCourseSummary.code
        * Composition.section:sliceRadioTherapyCourseSummary.entry
        * Composition.section:sliceRadioTherapyCourseSummary.text
        * Composition.section:sliceResultsSection
        * Composition.section:sliceResultsSection.code
        * Composition.section:sliceResultsSection.entry
        * Composition.section:sliceResultsSection.text
        * Composition.section:sliceSecondaryCancerCondition
        * Composition.section:sliceSecondaryCancerCondition.code
        * Composition.section:sliceSecondaryCancerCondition.entry
        * Composition.section:sliceSecondaryCancerCondition.text
        * Composition.section:sliceSocialHistorySection
        * Composition.section:sliceSocialHistorySection.code
        * Composition.section:sliceSocialHistorySection.entry
        * Composition.section:sliceSocialHistorySection.text
        * Composition.section:sliceVitalSignsSection
        * Composition.section:sliceVitalSignsSection.code
        * Composition.section:sliceVitalSignsSection.entry
        * Composition.section:sliceVitalSignsSection.text
        * Composition.status
        * Composition.subject
        * Composition.title
        * Composition.type.coding.code
      )

      id :ccrr_v100_composition_must_support_test

      def resource_type
        'Composition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:composition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
