require 'inferno/dsl/oauth_credentials'
require_relative 'version'

# require_relative 'hdea_suite/generated/v1.0.0/cancer_encounter_group'
# require_relative 'hdea_suite/generated/v1.0.0/cancer_patient_group'
require_relative 'hdea_suite/generated/v1.0.0/composition_group'
require_relative 'hdea_suite/generated/v1.0.0/ccrr_content_bundle_group'
require_relative 'hdea_suite/resources_validation_group'

module CancerRegistryReportingTestKit
  module CCRRV100
    class HDEASuite < Inferno::TestSuite
      title 'Cancer Registry Reporting Health Data Exchange App (HDEA) Test Suite'
      description %(
        The US Core Test Kit tests systems for their conformance to the [US Core
        Implementation Guide]().

        HL7® FHIR® resources are validated with the Java validator using
        `tx.fhir.org` as the terminology server. Users should note that the
        although the ONC Certification (g)(10) Standardized API Test Suite
        includes tests from this suite, [it uses a different method to perform
        terminology
        validation](https://github.com/onc-healthit/onc-certification-g10-test-kit/wiki/FAQ#q-why-do-some-resources-fail-in-us-core-test-kit-with-terminology-validation-errors).
        As a result, resource validation results may not be consistent between
        the US Core Test Suite and the ONC Certification (g)(10) Standardized
        API Test Suite.
      )
      version VERSION

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

        perform_additional_validation do |resource, profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      input :reports,
      title: 'Cancer Reports',
      description: 'Comma-Separated Content Bundle(s)',
      type: 'textarea'

      group from: :ccrr_v100_ccrr_content_bundle
      group from: :ccrr_v100_composition
      group from: :ccrr_report_resources_validation
    end
  end
end
