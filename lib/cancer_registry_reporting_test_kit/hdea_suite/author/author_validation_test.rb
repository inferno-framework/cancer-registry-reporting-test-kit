require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class AuthorValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_author_validation_test
      title 'Author resources returned during previous tests conform to the US Core Practitioner Role, Practitioner, or Organization Profile'
      description %(
This test verifies that author resources referenced in the provided cancer report conform to 
the [US Core PractitionerRole Profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole),
[US Core Practitioner Profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner), or
[US Core Organization Profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def scratch_resources
        scratch[:author_resources] ||= {}
      end

      run do
        p 'VLD AUTH'
        p scratch[:author_resources].length
        p scratch_resources[:all].length
        assert(false, 'Author (required) reference is not present or does not resolve') if scratch_resources[:all].blank?


        AUTHOR_PROFILES = {
          'PractitionerRole' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole',
          'Practitioner' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner',
          'Organization' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'
        }

        resources_by_type = {
          'PractitionerRole' => [],
          'Practitioner' => [],
          'Organization' => []
        }

        scratch_resources[:all].each do |author|
          resources_by_type[author.resourceType] << author
        end

        resources_by_type.each do |resource_type, resources|
          next if resources.blank?
          perform_validation_test(
            resource_type,
            resources,
            AUTHOR_PROFILES[resource_type],
            '3.1.1')
        end
      end
    end
  end
end
