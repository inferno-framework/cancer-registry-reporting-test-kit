# frozen_string_literal: true

require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class MedicationAdministrationMustSupportTest < Inferno::Test
    include USCoreTestKit::MustSupportTest

    title 'All must support elements are provided in the mCODE Cancer-Related MedicationAdministration resources returned'
    description %(
      CCRR EHRs SHALL be capable of populating all data elements as
      part of the query results. This test will look through the MedicationAdministration resources
      found previously for the following must support elements:

      * MedicationAdministration.effective[x]
      * MedicationAdministration.extension:treatmentIntent
      * MedicationAdministration.medication[x]
      * MedicationAdministration.reasonCode
      * MedicationAdministration.reasonReference
      * MedicationAdministration.status
      * MedicationAdministration.statusReason
      * MedicationAdministration.subject
    )

    id :ccrr_medication_administration_must_support_test

    def resource_type
      'MedicationAdministration'
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:medication_administration_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
