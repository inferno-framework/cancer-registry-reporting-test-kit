require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MedicationAdministrationValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_medication_administration_validation_test
      title 'MedicationAdministration resources in composition conform to the Cancer-Related Medication Administration Profile'
      description %(
This test verifies resources returned from the first search conform to
the [Cancer-Related Medication Administration Profile](http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'MedicationAdministration'
      end

      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration',
                                '3.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
