require_relative 'mcode_data_access_group/mcode_data_access_tests'


module CancerRegistryReportingTestKit
  class EHRmCodeDataAccessGroup < Inferno::TestGroup
    id :ccrr_mcode_data_access
    title 'mCode Data Access Group'
    short_description 'Verify that cancer patient mCode data are available.'
    description %(
        Tests verify that the EHR allows apps to access patient data defined in mCode and specified
        via searches [specified by Central Cancer Registry IG v1.0.0](https://build.fhir.org/ig/HL7/fhir-central-cancer-registry-reporting-ig/spec.html#mcode-fhir-ig-usage).
        These resources are searchable by parameters defined in the [mCode IG](http://hl7.org/fhir/us/mcode/STU3/index.html).
    )

    test from: :ccrr_ehr_mcode_tests

  end
end
