# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MedicationAdministrationMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Medication Administration resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the MedicationAdministration resources
        found previously for the following must support elements:

        * MedicationAdministration.effective[x]
        * MedicationAdministration.extension
        * MedicationAdministration.extension:treatmentIntent
        * MedicationAdministration.medication[x]
        * MedicationAdministration.reasonCode
        * MedicationAdministration.reasonReference
        * MedicationAdministration.status
        * MedicationAdministration.statusReason
        * MedicationAdministration.subject
      )

      id :ccrr_v100_medication_administration_must_support_test

      def resource_type
        'MedicationAdministration'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
