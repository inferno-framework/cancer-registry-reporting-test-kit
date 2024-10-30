

module CancerRegistryReportingTestKit
  class HDEAReportCompositionValidationTest < Inferno::Test
    title 'HDEA Report Composition Validation Test'
    id :ccrr_hdea_report_composition_validation_test

    description %(
        Verify that the HDEA generated report contains a valid
        [Report Composition](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-composition.html).
      )

      # extract each CCRR composition from the content bundle
      # validate the composition
  end
end