# frozen_string_literal: true

require 'inferno/dsl/oauth_credentials'
require 'us_core_test_kit'

require_relative 'ehr_capability_statement/mcode_capability_statement_profile_support'
require_relative 'mcode_data_access_resources/primary_cancer_condition_group'
require_relative 'mcode_data_access_resources/secondary_cancer_condition_group'
require_relative 'mcode_data_access_resources/medication_request_group'
require_relative 'mcode_data_access_resources/medication_administration_group'
require_relative 'mcode_data_access_resources/medication_administration/medication_administration_must_support_test'
require_relative 'mcode_data_access_resources/tnm_distant_metastases_category_group'
require_relative 'mcode_data_access_resources/tnm_primary_tumor_category_group'
require_relative 'mcode_data_access_resources/tnm_regional_nodes_category_group'
require_relative 'mcode_data_access_resources/tnm_stage_group_group'
require_relative 'mcode_data_access_resources/radiotherapy_procedure_group'

module CancerRegistryReportingTestKit
  class EHRDataAccessGroup < Inferno::TestGroup
    id :ccrr_ehr_data_access
    title 'EHR Data Access Group'
    short_description 'Verify that cancer patient data are available via US Core and mCODE APIs.'
    description %(
        During these tests, Inferno will simulate a FHIR client and verify that it can use the EHR's FHIR APIs
        to access patient data including both the [US Core](http://hl7.org/fhir/us/core/STU3.1.1/index.html)
        as well as [mCODE](https://hl7.org/fhir/us/mcode/STU3/index.html) data as specified by the
        [Central Cancer Registry IG v1.0.0](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/).
    )

    M_CODE_PROFILES = {
      'Condition' => [
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition',
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-primary-cancer-condition'
      ].freeze,
      'MedicationAdministration' => ['http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration'].freeze,
      'MedicationRequest' => ['http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-request'].freeze,
      'Observation' => [
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-stage-group',
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-distant-metastases-category',
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-primary-tumor-category',
        'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-regional-nodes-category'
      ].freeze,
      'Procedure' => ['http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary'].freeze
    }.freeze

    input :url,
          title: 'FHIR Endpoint',
          description: 'URL of the EHR\'s FHIR endpoint'

    input :smart_credentials,
          title: 'OAuth Credentials',
          type: :oauth_credentials,
          optional: true

    fhir_client do
      url :url
      oauth_credentials :smart_credentials
    end

    verifies_requirements 'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@1',
                          'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@31',
                          'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@54',
                          'hl7.fhir.us.mcode_3.0.0@107',
                          'hl7.fhir.us.mcode_3.0.0@108',
                          'hl7.fhir.us.mcode_3.0.0@109',
                          'hl7.fhir.us.mcode_3.0.0@110'

    group from: :us_core_v311_capability_statement do
      test from: :ccrr_mcode_capability_statement_profile_support do
        config(
          options: { required_profiles: [M_CODE_PROFILES.values].flatten }
        )
      end
    end

    group do
      title 'US Core FHIR API'
      id :ccrr_us_core_fhir_api

      verifies_requirements 'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@34',
                            'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@43'
      group from: :us_core_v311_patient, title: 'Patient'
      group from: :us_core_v311_allergy_intolerance, title: 'AllergyIntolerance'
      group from: :us_core_v311_care_plan, title: 'CarePlan'
      group from: :us_core_v311_care_team, title: 'CareTeam'
      group from: :us_core_v311_condition, title: 'Condition'
      group from: :us_core_v311_device, title: 'Device'
      group from: :us_core_v311_diagnostic_report_note, title: 'DiagnosticReport for Report and Note Exchange'
      group from: :us_core_v311_diagnostic_report_lab, title: 'DiagnosticReport for Laboratory Results Reporting'
      group from: :us_core_v311_document_reference, title: 'DocumentReference'
      group from: :us_core_v311_goal, title: 'Goal'
      group from: :us_core_v311_immunization, title: 'Immunization'
      group from: :us_core_v311_medication_request, title: 'MedicationRequest'
      group from: :us_core_v311_smokingstatus, title: 'Smoking Status Observation'
      group from: :us_core_v311_pediatric_weight_for_height, title: 'Pediatric Weight for Height Observation'
      group from: :us_core_v311_observation_lab, title: 'Laboratory Result Observation'
      group from: :us_core_v311_pediatric_bmi_for_age, title: 'Pediatric BMI for Age Observation'
      group from: :us_core_v311_pulse_oximetry, title: 'Pulse Oximetry Observation'
      group from: :us_core_v311_head_circumference, title: 'Pediatric Head Occipital-frontal Circumference Percentile Observation'
      group from: :us_core_v311_bodyheight, title: 'Body Height Observation'
      group from: :us_core_v311_bodytemp, title: 'Body Temperature Observation'
      group from: :us_core_v311_bp, title: 'Blood Pressure Observation'
      group from: :us_core_v311_bodyweight, title: 'Body Weight Observation'
      group from: :us_core_v311_heartrate, title: 'Heart Rate Observation'
      group from: :us_core_v311_resprate, title: 'Respiratory Rate Observation'
      group from: :us_core_v311_procedure, title: 'Procedure'
      group from: :us_core_v311_encounter, title: 'Encounter'
      group from: :us_core_v311_organization, title: 'Organization'
      group from: :us_core_v311_practitioner, title: 'Practitioner'
      group from: :us_core_v311_provenance, title: 'Provenance'
      group from: :us_core_311_data_absent_reason, title: 'Missing Data'
    end

    group do
      title 'mCODE FHIR API'
      id :ccrr_mcode_fhir_api

      verifies_requirements 'hl7.fhir.us.central-cancer-registry-reporting_1.0.0@35'

      group from: :ccrr_ehr_primary_cancer_condition
      group from: :ccrr_ehr_secondary_cancer_condition
      group from: :ccrr_ehr_medication_request
      group from: :ccrr_ehr_medication_administration
      group from: :ccrr_ehr_tnm_distant_metastases_category
      group from: :ccrr_ehr_tnm_primary_tumor_category
      group from: :ccrr_ehr_tnm_regional_nodes_category
      group from: :ccrr_ehr_tnm_stage_group
      group from: :ccrr_ehr_radiotherapy_procedure
    end
  end
end
