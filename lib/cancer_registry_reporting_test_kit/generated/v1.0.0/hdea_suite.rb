require 'inferno/dsl/oauth_credentials'
require_relative '../../version'

require_relative 'cancer_encounter_group'
require_relative 'cancer_patient_group'
require_relative 'composition_group'
require_relative 'ccrr_content_bundle_group'
require_relative 'plan_definition_group'
require_relative 'central_cancer_registry_primary_cancer_condition_group'
require_relative 'us_ph_patient_group'
require_relative 'extension_group'
require_relative 'medication_administration_group'
require_relative 'medication_request_group'
require_relative 'mcode_primary_cancer_condition_group'
require_relative 'mcode_radiotherapy_course_summary_group'
require_relative 'mcode_secondary_cancer_condition_group'
require_relative 'mcode_tnm_distant_metastases_category_group'
require_relative 'mcode_tnm_primary_tumor_category_group'
require_relative 'mcode_tnm_regional_nodes_category_group'
require_relative 'mcode_tnm_stage_group_group'
require_relative 'odh_usual_work_group'
require_relative 'allergy_intolerance_group'
require_relative 'care_plan_group'
require_relative 'diagnostic_report_lab_group'
require_relative 'diagnostic_report_note_group'
require_relative 'document_reference_group'
require_relative 'encounter_group'
require_relative 'medication_group'
require_relative 'observation_lab_group'
require_relative 'organization_group'
require_relative 'patient_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'
require_relative 'procedure_group'
require_relative 'smokingstatus_group'

module CancerRegistryReportingTestKit
  module CCRRV100
    class HDEASuite < Inferno::TestSuite
      title 'HDEA Suite'
      description %(
        The HDEA Test Kit tests systems for their conformance to the [
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

      id :ccrr_v100

      fhir_resource_validator do
        igs 'ccrr#1.0.0'
        message_filters = VALIDATION_MESSAGE_FILTERS

        exclude_message do |message|

          message_filters.any? { |filter| filter.match? message.message }
        end

        perform_additional_validation do |resource, profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      input :reports

      group do
        input :smart_credentials,
          title: 'OAuth Credentials',
          type: :oauth_credentials,
          optional: true

        fhir_client do
          url :url
          oauth_credentials :smart_credentials
        end

        title 'HDEA MS and Validation Sequence'
        id :ccrr_v100_fhir_api

      
        group from: :ccrr_v100_ccrr_content_bundle
        group from: :ccrr_v100_composition
        group from: :ccrr_v100_central_cancer_registry_primary_cancer_condition
        group from: :ccrr_v100_cancer_encounter
        group from: :ccrr_v100_plan_definition
        group from: :ccrr_v100_medication_administration
        group from: :ccrr_v100_medication_request
        group from: :ccrr_v100_mcode_primary_cancer_condition
        group from: :ccrr_v100_mcode_radiotherapy_course_summary
        group from: :ccrr_v100_mcode_secondary_cancer_condition
        group from: :ccrr_v100_mcode_tnm_distant_metastases_category
        group from: :ccrr_v100_mcode_tnm_primary_tumor_category
        group from: :ccrr_v100_mcode_tnm_regional_nodes_category
        group from: :ccrr_v100_mcode_tnm_stage_group
        group from: :ccrr_v100_odh_usual_work
        group from: :ccrr_v100_allergy_intolerance
        group from: :ccrr_v100_care_plan
        group from: :ccrr_v100_diagnostic_report_lab
        group from: :ccrr_v100_diagnostic_report_note
        group from: :ccrr_v100_document_reference
        group from: :ccrr_v100_encounter
        group from: :ccrr_v100_medication
        group from: :ccrr_v100_observation_lab
        group from: :ccrr_v100_organization
        group from: :ccrr_v100_patient
        group from: :ccrr_v100_practitioner
        group from: :ccrr_v100_practitioner_role
        group from: :ccrr_v100_procedure
        group from: :ccrr_v100_smokingstatus
      end
    end
  end
end
