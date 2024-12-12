require_relative 'hdea_suite/report_creation_group'
require_relative 'hdea_suite/must_support_group'



module CancerRegistryReportingTestKit
  class HDEASuite < Inferno::TestSuite
    id :ccrr_hdea
    title 'Cancer Registry Reporting Health Data Exchange App (HDEA) Test Suite'
    short_title 'CCRR Health Data Exchange App (HDEA)'
    description '
    The Cancer Registry Reporting HDEA Test Suite verifies the 
    conformance of Health Data Exchange Apps to the STU 1.0.0 version of the HL7® FHIR® 
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

    # All FHIR validation requests will use this FHIR validator
    fhir_resource_validator do
      igs 'hl7.fhir.us.central-cancer-registry-reporting#1.0.0', 'hl7.fhir.us.core#3.1.1'

      exclude_message do |message|
        message.message.match?(/\A\S+: \S+: URL value '.*' does not resolve/)
      end
    end

    group from: :ccrr_hdea_report_creation
    group from: :ccrr_hdea_must_support

  end
end