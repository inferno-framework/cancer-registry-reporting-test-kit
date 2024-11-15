require 'smart_app_launch/smart_stu1_suite'
require 'us_core_test_kit/custom_groups/smart_ehr_launch_stu1'
require 'us_core_test_kit/custom_groups/smart_standalone_launch_stu1_group'


module CancerRegistryReportingTestKit
  class SmartAppLaunchGroup < Inferno::TestGroup
    id :ccrr_smart_app_launch_group
    title 'Smart App Launch'
    
    SMART_V1_RESOURCE_LEVEL_SCOPES = 'launch/patient openid fhirUser offline_access patient/Medication.read patient/AllergyIntolerance.read patient/CarePlan.read patient/CareTeam.read patient/Condition.read patient/Device.read patient/DiagnosticReport.read patient/DocumentReference.read patient/Encounter.read patient/Goal.read patient/Immunization.read patient/Location.read patient/MedicationRequest.read patient/Observation.read patient/Organization.read patient/Patient.read patient/Practitioner.read patient/Procedure.read patient/Provenance.read patient/PractitionerRole.read patient/ServiceRequest.read patient/RelatedPerson.read patient/Specimen.read patient/MedicationDispense.read patient/Coverage.read patient/Location.read patient/media.read'.freeze

    SMART_V2_RESOURCE_LEVEL_SCOPES = 'launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/ServiceRequest.rs patient/RelatedPerson.rs patient/Specimen.rs patient/MedicationDispense.rs patient/Coverage.rs patient/Location.rs patient/Media.rs'.freeze

    group from: :us_core_smart_standalone_launch_stu1,
      optional: true,
            config: {
              inputs: {
                requested_scopes: { default: SmartAppLaunchGroup::SMART_V1_RESOURCE_LEVEL_SCOPES }
              }
            }
    group from: :us_core_smart_ehr_launch_stu1,
      optional: true,
            config: {
              inputs: {
                requested_scopes: { default: SmartAppLaunchGroup::SMART_V1_RESOURCE_LEVEL_SCOPES }
              }
            }

  end
end
