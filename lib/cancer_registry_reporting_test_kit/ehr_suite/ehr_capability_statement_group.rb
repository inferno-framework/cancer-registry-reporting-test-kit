require_relative 'ehr_capability_statement/mcode_requirement_22_profile_support'
require_relative 'ehr_capability_statement/mcode_requirement_103_conformance_interaction'

module CancerRegistryReportingTestKit
  class EHRCapabilityStatementGroup < Inferno::TestGroup

    id :ehr_capability_statement_group
    title 'EHR Capability Statement'
    description "
        # Background
        The #{title} Sequence tests a FHIR server's ability to formally describe
        features supported by the API by using the [Capability
        Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
        The features described in the Capability Statement must be consistent with
        the required capabilities of a EHR server).

        The Capability Statement resource allows clients to determine which
        resources are supported by a FHIR Server.

        # Test Methodology

        This test sequence accesses the server endpoint at `/metadata` using a
        `GET` request. It parses the Capability Statement and verifies that:

        * The endpoint is secured by an appropriate cryptographic protocol
        * The server claims support for all required profiles

        It collects the following information that is saved in the testing session
        for use by later tests:

        * List of resources supported
      "

    US_CORE_PROFILES = {
      'AllergyIntolerance' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance'].freeze,
      'CarePlan' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'].freeze,
      'CareTeam' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-careteam'].freeze,
      'Condition' => [
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-encounter-diagnosis',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns'
      ].freeze,
      'Coverage' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-coverage'].freeze,
      'Device' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-implantable-device'].freeze,
      'DiagnosticReport' => [
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'
      ].freeze,
      'DocumentReference' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference'].freeze,
      'Encounter' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter'].freeze,
      'Goal' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-goal'].freeze,
      'Immunization' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization'].freeze,
      'Location' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-location'].freeze,
      'Medication' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'].freeze,
      'MedicationDispense' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationdispense'].freeze,
      'MedicationRequest' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest'].freeze,
      'Observation' => [
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-average-blood-pressure',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-care-experience-preference',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-clinical-result',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-occupation',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-pregnancyintent',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-pregnancystatus',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-screening-assessment',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-sexual-orientation',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-simple-observation',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-treatment-intervention-preference',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-vital-signs',
        'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age',
        'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-blood-pressure',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-bmi',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-height',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-temperature',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-weight',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-head-circumference',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-heart-rate',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-pulse-oximetry',
        'http://hl7.org/fhir/us/core/StructureDefinition/us-core-respiratory-rate',
        'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile'
      ].freeze,
      'Organization' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'].freeze,
      'Patient' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'].freeze,
      'Practitioner' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'].freeze,
      'PractitionerRole' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'].freeze,
      'Procedure' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure'].freeze,
      'Provenance' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-provenance'].freeze,
      'QuestionnaireResponse' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-questionnaireresponse'].freeze,
      'RelatedPerson' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-relatedperson'].freeze,
      'ServiceRequest' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-servicerequest'].freeze,
      'Specimen' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-specimen'].freeze
    }.freeze

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

    test from: :mcode_requirement_103_conformance_interaction

    test from: :mcode_requirement_22_profile_support do
      config(
        options: { required_profiles: [US_CORE_PROFILES.values, M_CODE_PROFILES.values].flatten}
      )
    end

  end
end