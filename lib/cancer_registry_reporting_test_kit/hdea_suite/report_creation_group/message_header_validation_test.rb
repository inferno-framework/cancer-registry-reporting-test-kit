require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MessageHeaderValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_message_header_validation_test
      title 'MessageHeader resources returned during previous tests conform to the Central Cancer Registry Reporting Message Header'
      description %(
This test verifies resources returned from the first search conform to
the [Central Cancer Registry Reporting Message Header](http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-reporting-messageheader).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'MessageHeader'
      end

      def scratch_resources
        scratch[:message_header_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-reporting-messageheader',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
