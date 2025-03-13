# frozen_string_literal: true

require 'inferno/dsl/oauth_credentials'
require_relative 'version'

require_relative 'hdea_suite/generated/v1.0.0/composition_group'
require_relative 'hdea_suite/generated/v1.0.0/ccrr_content_bundle_group'
require_relative 'hdea_suite/bundle_resources_group'

module CancerRegistryReportingTestKit
  module CCRRV100
    class HDEASuite < Inferno::TestSuite
      title 'Cancer Registry Reporting Health Data Exchange App (HDEA) Test Suite'
      description %(
    The Cancer Registry Reporting HDEA Test Suite verifies the
    conformance of Health Data Exchange Apps to the STU 1.0.0 version of the HL7® FHIR®
    [Central Cancer Registry Reporting IG](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/).

    ## Scope
    All resources referenced as on must support fields in the
    CCRR [Composition](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-composition.html)
    are covered in HDEA tests. Profiles defined or specified in the IG, but not specifically included or marked MS in the
    composition are out of scope. Additionally,
    Inferno does not test transmission of resources to the cancer registry.

    ## Test Methodology
    Inferno takes a set of bundles, each having its individual resources extracted and checked for conformance to the requisite profiles, as
    defined in the CCRR [Composition](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/StructureDefinition-ccrr-composition.html).

    ## Current Limitations

      )
      version VERSION

      GENERAL_MESSAGE_FILTERS = [
        %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /Observation\.effective\.ofType\(Period\): .*us-core-1:/, # Invalid invariant in US Core v3.1.1
        /Provenance.agent\[\d*\]: Constraint failed: provenance-1/, # Invalid invariant in US Core v5.0.1
        %r{Unknown Code System 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags'}, # Validator has an issue with
        # this US Core 5 code system in US Core 6 resource
        %r{URL value 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags' does not resolve}, # Validator has an issue with this
        # US Core 5 code system in US Core 6 resource
        /\A\S+: \S+: URL value '.*' does not resolve/,
        %r{Observation.component\[\d+\].value.ofType\(Quantity\): The code provided \(http://unitsofmeasure.org#L/min\)
        was not found in the value set 'Vital Signs Units'} # Known issue with the Pulse Oximetry Profile
      ].freeze
      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      id :ccrr_v100_report_generation

      fhir_resource_validator do
        igs 'hl7.fhir.us.central-cancer-registry-reporting#1.0.0', 'hl7.fhir.us.core#5.0.1'
        message_filters = VALIDATION_MESSAGE_FILTERS

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end

        perform_additional_validation do |resource, _profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      input :reports,
            title: 'Cancer Reports',
            description: 'Comma-Separated Content Bundle(s)',
            type: 'textarea'

      group from: :ccrr_v100_ccrr_content_bundle
      group from: :ccrr_v100_composition
      group from: :ccrr_report_resources
    end
  end
end
