require_relative 'us_core_data_access_group/us_core_data_access_tests'

module CancerRegistryReportingTestKit
  class EHRUSCoreDataAccessGroup < Inferno::TestGroup
    id :ccrr_us_core_data_access
    title 'US Core Data Access Group'
    short_description 'Verify that cancer patient data are available via US Core API.'
    description %(
        Tests verify that the EHR allows apps to access patient data via the [US Core API](http://hl7.org/fhir/us/core/STU3.1.1/index.html) 
        as specified by the 
        [Central Cancer Registry IG v1.0.0](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/). 
    )

    test from: :ccrr_ehr_us_core_tests

  end
end
