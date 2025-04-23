require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class RadiotherapyProcedureMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the mCODE Radiotherapy Course Summary Procedure resources returned'
    description %(
        CCRR EHRs SHALL be capable of populating all data elements as
        part of the query results. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.bodySite
        * Procedure.code
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
        * Procedure.subject
      )

    id :ccrr_radiotherapy_procedure_must_support_test

    def resource_type
      'Procedure'
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:radiotherapy_procedure_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
