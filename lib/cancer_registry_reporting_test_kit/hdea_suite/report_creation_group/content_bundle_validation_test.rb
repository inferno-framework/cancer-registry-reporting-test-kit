# frozen_string_literal: true

module CancerRegistryReportingTestKit
  class HDEAContentBundleValidationTest < Inferno::Test
    title 'HDEA Content Bundle Validation Test'
    id :ccrr_hdea_content_bundle_validation_test

    description %(
        Verify that the HDEA generated report is a conformant
        [Content Bundle](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-content-bundle.html).
        Will also verify that the included composition is a conformant
        [Report Composition](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-composition.html).
      )

    run do
      skip_if single_report.blank?, 'No CCRR Bundle Provided'

      assert_valid_json(single_report)
      resource_instance = FHIR.from_contents(single_report)

      assert_resource_type(:bundle, resource: resource_instance)
      assert_valid_resource(resource: resource_instance, profile_url: 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle|1.0.0')
    end
  end
end