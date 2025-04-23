# frozen_string_literal: true

require_relative '../../../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class AllergyIntoleranceValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_allergy_intolerance_validation_test
      title 'US Core AllergyIntolerance profile conformance'
      description %(
        This test verifies that AllergyIntolerance instances
        found in the Allergies sections of the provided reports conform to the
        [US Core AllergyIntolerance profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance|5.0.1).
      )
      

      def resource_type
        'AllergyIntolerance'
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance',
                                '5.0.1',
                                skip_if_empty: true)
      end
    end
  end
end
