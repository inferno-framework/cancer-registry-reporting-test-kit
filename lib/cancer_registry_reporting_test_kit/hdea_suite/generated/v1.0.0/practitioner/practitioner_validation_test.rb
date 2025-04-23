# frozen_string_literal: true

require_relative '../../../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class PractitionerValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_practitioner_validation_test
      title 'US Core Practitioner profile conformance'
      description %(
        This test verifies that Practitioner instances
        referenced in the `author` elements of the provided reports conform to the
        [US Core Practitioner profile](http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner|5.0.1).
      )
      

      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner',
                                '5.0.1',
                                skip_if_empty: true)
      end
    end
  end
end
