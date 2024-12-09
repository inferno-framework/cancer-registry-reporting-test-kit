require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class McodeSecondaryCancerConditionValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_mcode_secondary_cancer_condition_validation_test
      title 'Secondary Cancer Condition resources in composition slice conforms to the mCode Secondary Cancer Condition profile'
      description %(
This test verifies resources returned from the first search conform to
the [Secondary Cancer Condition Profile](http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:mcode_secondary_cancer_condition_resources] ||= {}
      end

      run do
        # TODO: Check for type due to open slicing. For now, enforce check for only 1 resource
        skip_if scratch_resources[:all].nil?, 'No resources found'
        assert scratch_resources[:all].length < 2, "Test currently allows only for 1 resource for this type."

        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition',
                                '3.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
