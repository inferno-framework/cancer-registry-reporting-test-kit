require_relative 'ehr_suite/ehr_data_access_group'
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
    
    These tests are a DRAFT intended to allow payer implementers to perform preliminary checks of their systems against CCRR IG requirements.
    Future versions of these tests may validate other requirements and may change the test validation logic.

    ## Test Methodology
    
    Inferno will simulate a health data exchange app, gathering data from an EHR with cancer patient information.
    The CCRR IG specifies support of the US Core API (v3.0.0) as well as support for particular 
    [mCode profiles](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/spec.html#mcode-fhir-ig-usage).
    For US Core resources, the user only provides patient IDs and Inferno searches for each US Core resource, checking for MS elements
    and profile conformance. mCode resources do not necessarily have specified codes for searching, so the user will provide 
    search parameters for each resource type. Likewise, the returned resources are checked for MS elements and conformance to 
    corresponding mCode profiles.

    ## Current Limitations
    
    While no authentication process is currently supported via Inferno, the user must provide an access token to inferno. 
    With that token, Inferno can make requests to the EHR under test.
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

    GENERAL_MESSAGE_FILTERS = [
      %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
      %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
      /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
      /Observation\.effective\.ofType\(Period\): .*us-core-1:/, # Invalid invariant in US Core v3.1.1
      /Provenance.agent\[\d*\]: Constraint failed: provenance-1/, #Invalid invariant in US Core v5.0.1
      %r{Unknown Code System 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags'}, # Validator has an issue with this US Core 5 code system in US Core 6 resource
      %r{URL value 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags' does not resolve}, # Validator has an issue with this US Core 5 code system in US Core 6 resource
      /\A\S+: \S+: URL value '.*' does not resolve/,
      %r{Observation.component\[\d+\].value.ofType\(Quantity\): The code provided \(http://unitsofmeasure.org#L/min\) was not found in the value set 'Vital Signs Units'} # Known issue with the Pulse Oximetry Profile
    ].freeze

    VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

    VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

    def self.metadata
      @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
    end

    fhir_resource_validator do
      igs('hl7.fhir.us.core#3.1.1', 'hl7.fhir.us.mcode#3.0.0')
      message_filters = VALIDATION_MESSAGE_FILTERS

      exclude_message do |message|

        message_filters.any? { |filter| filter.match? message.message }
      end

      perform_additional_validation do |resource, profile_url|
        USCoreTestKit::ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
      end
    end

    group from: :ccrr_ehr_data_access

  end
end