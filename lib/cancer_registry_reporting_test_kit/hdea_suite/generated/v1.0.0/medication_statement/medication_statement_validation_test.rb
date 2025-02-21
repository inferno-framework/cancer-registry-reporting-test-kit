# frozen_string_literal: true

require_relative '../../../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MedicationStatementValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_medication_statement_validation_test
      title 'MedicationStatement resources returned during previous tests conform to the Base MedicationStatement profile'
      description %(
This test verifies resources returned from the first search conform to
the [Base MedicationStatement](http://hl7.org/fhir/StructureDefinition/MedicationStatement).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'MedicationStatement'
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/StructureDefinition/MedicationStatement',
                                '4.0.1',
                                skip_if_empty: true)
      end
    end
  end
end
