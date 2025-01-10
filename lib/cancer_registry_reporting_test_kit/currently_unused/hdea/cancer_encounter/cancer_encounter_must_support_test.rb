require_relative '../../../must_support_test'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CancerEncounterMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Cancer Encounter resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Encounter resources
        found previously for the following must support elements:

        * Encounter.class
        * Encounter.diagnosis
        * Encounter.diagnosis.condition
        * Encounter.diagnosis.use
        * Encounter.hospitalization
        * Encounter.hospitalization.dischargeDisposition
        * Encounter.identifier
        * Encounter.identifier.system
        * Encounter.identifier.value
        * Encounter.location
        * Encounter.location.location
        * Encounter.participant
        * Encounter.participant.individual
        * Encounter.participant.period
        * Encounter.participant.type
        * Encounter.participant:sliceResponsibleProvider
        * Encounter.participant:sliceResponsibleProvider.individual
        * Encounter.participant:sliceResponsibleProvider.period
        * Encounter.participant:sliceResponsibleProvider.type
        * Encounter.period
        * Encounter.reasonCode
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.status
        * Encounter.subject
        * Encounter.type
      )

      id :ccrr_v100_cancer_encounter_must_support_test

      def resource_type
        'Encounter'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:cancer_encounter_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
