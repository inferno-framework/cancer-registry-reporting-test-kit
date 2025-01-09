require_relative '../../../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class McodeRadiotherapyCourseSummaryValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_mcode_radiotherapy_course_summary_validation_test
      title 'Procedure resources returned during previous tests conform to the Radiotherapy Course Summary Profile profile'
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
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary',
                                '3.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
