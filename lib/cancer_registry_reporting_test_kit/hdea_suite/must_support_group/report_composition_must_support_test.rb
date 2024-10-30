

module CancerRegistryReportingTestKit
  class HDEAReportCompositionMustSupportTest < Inferno::Test
    title 'HDEA Report Composition Must Support Test'
    id :ccrr_hdea_report_composition_must_support_test

    description %(
        Verify that the HDEA generated
        [Report Composition(s)](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-composition.html)
        represent all Must Support fields.
      )

  end
end