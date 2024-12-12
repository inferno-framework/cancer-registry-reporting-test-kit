module CancerRegistryReportingTestKit
  class Generator
    module Naming
      ALLERGY_INTOLERANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance'
      CARE_PLAN = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'
      CARE_TEAM = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careteam'
      CONDITION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition'
      IMPLANTABLE_DEVICE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-implantable-device'
      DIAGNOSTIC_REPORT_NOTE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'
      DIAGNOSTIC_REPORT_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab'
      DOCUMENT_REFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference'
      ENCOUNTER = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter'
      GOAL = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-goal'
      IMMUNIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization'
      LOCATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-location'
      MEDICATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'
      MEDICATION_REQUEST = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest'
      SMOKINGSTATUS = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
      PEDIATRIC_WEIGHT_FOR_HEIGHT = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height'
      OBSERVATION_LAB = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab'
      PEDIATRIC_BMI_FOR_AGE = 'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age'
      PULSE_OXIMETRY = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-pulse-oximetry'
      HEAD_CIRCUMFERENCE = 'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile'
      ORGANIZATION = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'
      PATIENT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'
      PRACTITIONER = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'
      PRACTITIONER_ROLE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'
      PROCEDURE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure'
      PROVENANCE = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-provenance'
      SERVICE_REQUEST = 'http://hl7.org/fhir/StructureDefinition/ServiceRequest'

      ## FOR HDEA
      COMPOSITION = 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-composition'
      CCRR_CONTENT_BUNDLE = 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle'
      CENTRAL_CANCER_REGISTRY_PRIMARY_CANCER_CONDITION = 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-primary-cancer-condition'
      MCODE_SECONDARY_CANCER_CONDITION = 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition'
      MCODE_TNM_STAGE_GROUP = 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-stage-group'
      MCODE_RADIOTHERAPY_COURSE_SUMMARY = 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary' 
      ODH_USUAL_WORK = 'http://hl7.org/fhir/us/odh/StructureDefinition/odh-UsualWork'
      OBSERVATION = 'http://hl7.org/fhir/StructureDefinition/Observation'
      MEDICATION_ADMINISTRATION = 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration'

      IG_LINKS = {
        'v3.1.1' => 'http://hl7.org/fhir/us/core/STU3.1.1',
        'v4.0.0' => 'http://hl7.org/fhir/us/core/STU4',
        'v5.0.1' => 'http://hl7.org/fhir/us/core/STU5.0.1',
        'v6.1.0' => 'http://hl7.org/fhir/us/core/STU6.1',
        'v7.0.0' => 'http://hl7.org/fhir/us/core/STU7'
      }.freeze

      class << self
        def resources_with_multiple_profiles
          # ['Condition', 'DiagnosticReport', 'Observation']
          ['Patient', 'Encounter', 'Bundle', 'Observation', 'DiagnosticReport', 'Condition', 'Procedure']
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          if group_metadata.profile_url == HEAD_CIRCUMFERENCE
            return group_metadata.reformatted_version == 'v311' ? 'head_circumference' : 'head_circumference_percentile'
          end

          group_metadata.name
            .delete_prefix('us_core_')
            .gsub('diagnosticreport', 'diagnostic_report')
            .underscore
        end

        ## HDEA QUICK PATCH
        def snake_case_for_url(url)
          snake_case = constants.find do |const_name|
            const_get(const_name) == url
          end
          return snake_case.to_s.downcase
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end

        def ig_link(version)
          IG_LINKS[version]
        end
      end
    end
  end
end
