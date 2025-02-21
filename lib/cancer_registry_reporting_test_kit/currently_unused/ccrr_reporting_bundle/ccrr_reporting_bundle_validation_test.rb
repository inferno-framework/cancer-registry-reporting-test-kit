# frozen_string_literal: true

require_relative '../../../../validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CcrrReportingBundleValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest

      id :ccrr_v100_ccrr_reporting_bundle_validation_test
      title 'Bundle resources returned during previous tests conform to the Central Cancer Registry Reporting Bundle profile'
      description %(
This test verifies resources returned from the first search conform to
the [Central Cancer Registry Reporting Bundle](http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-reporting-bundle).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:ccrr_reporting_bundle_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-reporting-bundle',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
