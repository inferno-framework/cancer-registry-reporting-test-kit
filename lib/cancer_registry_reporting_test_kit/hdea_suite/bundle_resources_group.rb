# frozen_string_literal: true

require_relative 'author/author_validation_test'
require_relative 'generated/v1.0.0/allergy_intolerance/allergy_intolerance_validation_test'
require_relative 'generated/v1.0.0/care_plan/care_plan_validation_test'
require_relative 'generated/v1.0.0/central_cancer_registry_primary_cancer_condition/central_cancer_registry_primary_cancer_condition_validation_test'
require_relative 'generated/v1.0.0/condition/condition_validation_test'
require_relative 'generated/v1.0.0/diagnostic_report_lab/diagnostic_report_lab_validation_test'
require_relative 'generated/v1.0.0/diagnostic_report_note/diagnostic_report_note_validation_test'
require_relative 'generated/v1.0.0/document_reference/document_reference_validation_test'
require_relative 'generated/v1.0.0/encounter/encounter_validation_test'
require_relative 'generated/v1.0.0/mcode_radiotherapy_course_summary/mcode_radiotherapy_course_summary_validation_test'
require_relative 'generated/v1.0.0/mcode_secondary_cancer_condition/mcode_secondary_cancer_condition_validation_test'
require_relative 'generated/v1.0.0/mcode_tnm_stage_group/mcode_tnm_stage_group_validation_test'
require_relative 'generated/v1.0.0/medication/medication_validation_test'
require_relative 'generated/v1.0.0/medication_administration/medication_administration_validation_test'
require_relative 'generated/v1.0.0/medication_request/medication_request_validation_test'
require_relative 'generated/v1.0.0/medication_statement/medication_statement_validation_test'
require_relative 'generated/v1.0.0/observation/observation_validation_test'
require_relative 'generated/v1.0.0/observation_lab/observation_lab_validation_test'
require_relative 'generated/v1.0.0/odh_usual_work/odh_usual_work_validation_test'
require_relative 'generated/v1.0.0/patient/patient_validation_test'
require_relative 'generated/v1.0.0/procedure/procedure_validation_test'
require_relative 'generated/v1.0.0/service_request/service_request_validation_test'
require_relative 'generated/v1.0.0/smokingstatus/smokingstatus_validation_test'

require_relative 'author/organization_must_support_test'
require_relative 'author/practitioner_must_support_test'
require_relative 'author/practitioner_role_must_support_test'
require_relative 'generated/v1.0.0/allergy_intolerance/allergy_intolerance_must_support_test'
require_relative 'generated/v1.0.0/care_plan/care_plan_must_support_test'
require_relative "generated/v1.0.0/central_cancer_registry_primary_cancer_condition/\
central_cancer_registry_primary_cancer_condition_must_support_test"
require_relative 'generated/v1.0.0/condition/condition_must_support_test'
require_relative 'generated/v1.0.0/diagnostic_report_lab/diagnostic_report_lab_must_support_test'
require_relative 'generated/v1.0.0/diagnostic_report_note/diagnostic_report_note_must_support_test'
require_relative 'generated/v1.0.0/document_reference/document_reference_must_support_test'
require_relative 'generated/v1.0.0/encounter/encounter_must_support_test'
require_relative 'generated/v1.0.0/mcode_radiotherapy_course_summary/mcode_radiotherapy_course_summary_must_support_test'
require_relative 'generated/v1.0.0/mcode_secondary_cancer_condition/mcode_secondary_cancer_condition_must_support_test'
require_relative 'generated/v1.0.0/mcode_tnm_stage_group/mcode_tnm_stage_group_must_support_test'
require_relative 'generated/v1.0.0/medication/medication_must_support_test'
require_relative 'generated/v1.0.0/medication_administration/medication_administration_must_support_test'
require_relative 'generated/v1.0.0/medication_request/medication_request_must_support_test'
require_relative 'generated/v1.0.0/medication_statement/medication_statement_must_support_test'
require_relative 'generated/v1.0.0/observation/observation_must_support_test'
require_relative 'generated/v1.0.0/observation_lab/observation_lab_must_support_test'
require_relative 'generated/v1.0.0/odh_usual_work/odh_usual_work_must_support_test'
require_relative 'generated/v1.0.0/patient/patient_must_support_test'
require_relative 'generated/v1.0.0/procedure/procedure_must_support_test'
require_relative 'generated/v1.0.0/service_request/service_request_must_support_test'
require_relative 'generated/v1.0.0/smokingstatus/smokingstatus_must_support_test'

module CancerRegistryReportingTestKit
  class ReportValidationTestsGroup < Inferno::TestGroup
    title 'Cancer Report Resource Validation Tests'
    short_description 'Verify conformance of resources to requisite profiles.'
    description %(
    # Background

    Tests verify that the system under test is
    able to provide cancer reports with profile conformant resources. The bundles must include compositions that reference the resources
    to be tested, as specified in the [Central Cancer Registry IG v1.0.0](https://hl7.org/fhir/us/cancer-reporting/STU1.0.1).


    # Testing Methodology
    Provided bundles are parsed for individual resources and profile conformance is verified.

    ## Profile Validation
    Each resource extracted from the bundles is expected to conform to
    the requisite profile. Each element is checked against
    teminology binding and cardinality requirements.


    ## Reference Validation
    Each reference made to resources in the composition must resolve to an extractable resource in the corresponding bundle.


    )

    id :ccrr_report_resources
    run_as_group

    test from: :ccrr_v100_patient_validation_test
    test from: :ccrr_v100_patient_must_support_test
    test from: :ccrr_v100_encounter_validation_test
    test from: :ccrr_v100_encounter_must_support_test
    test from: :ccrr_v100_author_validation_test
    test from: :ccrr_v100_organization_must_support_test
    test from: :ccrr_v100_practitioner_must_support_test
    test from: :ccrr_v100_practitioner_role_must_support_test
    test from: :ccrr_v100_central_cancer_registry_primary_cancer_condition_validation_test
    test from: :ccrr_v100_central_cancer_registry_primary_cancer_condition_must_support_test
    test from: :ccrr_v100_mcode_secondary_cancer_condition_validation_test
    test from: :ccrr_v100_mcode_secondary_cancer_condition_must_support_test
    test from: :ccrr_v100_mcode_tnm_stage_group_validation_test
    test from: :ccrr_v100_mcode_tnm_stage_group_must_support_test
    test from: :ccrr_v100_mcode_radiotherapy_course_summary_validation_test
    test from: :ccrr_v100_mcode_radiotherapy_course_summary_must_support_test
    test from: :ccrr_v100_condition_validation_test
    test from: :ccrr_v100_condition_must_support_test
    test from: :ccrr_v100_allergy_intolerance_validation_test
    test from: :ccrr_v100_allergy_intolerance_must_support_test
    test from: :ccrr_v100_medication_administration_validation_test
    test from: :ccrr_v100_medication_administration_must_support_test
    test from: :ccrr_v100_medication_validation_test
    test from: :ccrr_v100_medication_must_support_test
    test from: :ccrr_v100_medication_statement_validation_test
    test from: :ccrr_v100_medication_statement_must_support_test
    test from: :ccrr_v100_odh_usual_work_validation_test
    test from: :ccrr_v100_odh_usual_work_must_support_test
    test from: :ccrr_v100_observation_lab_validation_test
    test from: :ccrr_v100_observation_lab_must_support_test
    test from: :ccrr_v100_diagnostic_report_lab_validation_test
    test from: :ccrr_v100_diagnostic_report_lab_must_support_test
    test from: :ccrr_v100_document_reference_validation_test
    test from: :ccrr_v100_document_reference_must_support_test
    test from: :ccrr_v100_diagnostic_report_note_validation_test
    test from: :ccrr_v100_medication_request_validation_test
    test from: :ccrr_v100_medication_request_must_support_test
    test from: :ccrr_v100_service_request_validation_test
    test from: :ccrr_v100_service_request_must_support_test
    test from: :ccrr_v100_care_plan_validation_test
    test from: :ccrr_v100_care_plan_must_support_test
    test from: :ccrr_v100_procedure_validation_test
    test from: :ccrr_v100_procedure_must_support_test
    test from: :ccrr_v100_observation_validation_test
    test from: :ccrr_v100_observation_must_support_test
    test from: :ccrr_v100_smokingstatus_validation_test
    test from: :ccrr_v100_smokingstatus_must_support_test
  end
end
