require_relative '../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class McodeRadiotherapyCourseSummaryValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_mcode_radiotherapy_course_summary_validation_test
      title 'RadioTherapyCourseSummary resources in composition slice conforms to the Radiotherapy Course Summary Profile'
      description %(
This test verifies resources returned from the first search conform to
the [Radiotherapy Course Summary Profile](http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Procedure'
      end

      def scratch_resources
        scratch[:mcode_radiotherapy_course_summary_resources] ||= {}
      end

      run do
        # TODO: Check for type due to open slicing. For now, enforce check for only 1 resource
        assert scratch_resources[:all].length < 2, "Test currently allows only for 1 resource for this type."

        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary',
                                '3.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
