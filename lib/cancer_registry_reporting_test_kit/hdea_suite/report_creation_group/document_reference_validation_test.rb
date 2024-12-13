require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class DocumentReferenceValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_document_reference_validation_test
      title 'Note resources in composition slice conforms to US Core DocumentReference Profile'
      description %(
This test verifies resources returned from the first search conform to
the [US Core DocumentReference Profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'DocumentReference'
      end

      def scratch_resources
        scratch[:document_reference_resources] ||= {}
      end

      run do
        # TODO: Check for type due to open slicing. For now, enforce check for only 1 resource
        skip_if scratch_resources[:all].nil?, 'No resources found'
        assert scratch_resources[:all].length < 2, "Test currently allows only for 1 resource for this type."
        
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference',
                                '3.1.1',
                                skip_if_empty: true)
      end
    end
  end
end
