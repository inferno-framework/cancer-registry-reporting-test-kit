require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class RadiotherapyProcedureMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the Mcode Radiotherapy Course Summary resources returned'
    description "
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.bodySite
        * Procedure.code.coding.code
        * Procedure.extension
        * Procedure.extension:actualNumberOfSessions
        * Procedure.extension:doseDeliveredToVolume
        * Procedure.extension:modalityAndTechnique
        * Procedure.extension:terminationReason
        * Procedure.extension:treatmentIntent
        * Procedure.performed[x]
        * Procedure.reasonCode
        * Procedure.reasonReference
        * Procedure.status
        * Procedure.subject"

    id :radiotherapy_procedure_must_support_test

    def resource_type
      'Procedure'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:radiotherapy_procedure_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
