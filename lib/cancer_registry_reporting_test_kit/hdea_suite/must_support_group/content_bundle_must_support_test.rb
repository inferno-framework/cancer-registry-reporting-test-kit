

module CancerRegistryReportingTestKit
  class HDEAContentBundleMustSupportTest < Inferno::Test
    title 'HDEA Content Bundle Must Support Test'
    id :ccrr_hdea_content_bundle_must_support_test

    description %(
        Verify that the HDEA generated
        [Content Bundle(s)](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-content-bundle.html)
        represent all Must Support fields.
      )

  end
end