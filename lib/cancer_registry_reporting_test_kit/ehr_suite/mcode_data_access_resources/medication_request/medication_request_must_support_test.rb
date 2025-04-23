# frozen_string_literal: true

require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class MedicationRequestMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the mCODE Cancer-Related MedicationRequest resources returned'
    description %(
      CCRR EHRs SHALL be capable of populating all data elements as
      part of the query results. This test will look through the MedicationRequest resources
      found previously for the following must support elements:

      * MedicationRequest.authoredOn
      * MedicationRequest.category
      * MedicationRequest.dispenseRequest
      * MedicationRequest.dispenseRequest.numberOfRepeatsAllowed
      * MedicationRequest.dispenseRequest.quantity
      * MedicationRequest.dosageInstruction
      * MedicationRequest.dosageInstruction.doseAndRate
      * MedicationRequest.dosageInstruction.doseAndRate.dose[x]
      * MedicationRequest.dosageInstruction.text
      * MedicationRequest.dosageInstruction.timing
      * MedicationRequest.encounter
      * MedicationRequest.extension:treatmentIntent
      * MedicationRequest.medication[x]
      * MedicationRequest.reasonCode
      * MedicationRequest.reasonReference
      * MedicationRequest.reported[x]
      * MedicationRequest.requester
      * MedicationRequest.status
      * MedicationRequest.statusReason
      * MedicationRequest.subject
    )

    id :ccrr_medication_request_must_support_test

    def resource_type
      'MedicationRequest'
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:medication_request_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
