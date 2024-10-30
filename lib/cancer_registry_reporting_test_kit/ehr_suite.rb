require_relative 'ehr_suite/us_core_data_access_group'
require_relative 'ehr_suite/mcode_data_access_group'



module CancerRegistryReportingTestKit
  class EHRSuite < Inferno::TestSuite
    id :ccrr_ehr
    title 'Cancer Registry Reporting Electronic Health Record (EHR) Test Suite'
    short_title 'CCRR Electornic Health Record (EHR)'
    description '
    The Cancer Registry Reporting EHR Test Suite verifies the 
    conformance of EHRs to the STU 1.0.0 version of the HL7® FHIR® 
    [Central Cancer Registry Reporting IG](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/).
    
    ## Scope
    ## Test Methodology
    ## Current Limitations
    '

    links [
      # {
      #   label: 'Report Issue',
      #   url: 'https://github.com/inferno-framework/cancer-registry-reporting-test-kit/issues'
      # },
      # {
      #   label: 'Open Source',
      #   url: 'https://github.com/inferno-framework/cancer-registry-reporting-test-kit'
      # },
      # {
      #   label: 'Download',
      #   url: 'https://github.com/inferno-framework/cancer-registry-reporting-test-kit/releases'
      # },
      {
        label: 'Implementation Guide',
        url: 'https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/'
      }
    ]

    input :url,
    title: 'FHIR Endpoint',
    description: 'Base FHIR URL of the EHR'

    input :credentials,
    title: 'OAuth Credentials',
    type: :oauth_credentials


    group from: :ccrr_us_core_data_access
    group from: :ccrr_mcode_data_access

  end
end