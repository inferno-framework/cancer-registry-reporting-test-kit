require_relative 'validation/cancer_encounter_validation_test'
require_relative 'validation/cancer_patient_validation_test'
require_relative 'validation/plan_definition_validation_test'
require_relative 'validation/ccrr_reporting_bundle_validation_test'
require_relative 'validation/central_cancer_registry_primary_cancer_condition_validation_test'
require_relative 'validation/message_header_validation_test'
require_relative 'validation/us_ph_patient_validation_test'
require_relative 'validation/extension_validation_test'
require_relative 'validation/medication_administration_validation_test'
require_relative 'validation/mcode_radiotherapy_course_summary_validation_test'
require_relative 'validation/mcode_secondary_cancer_condition_validation_test'
require_relative 'validation/mcode_tnm_stage_group_validation_test'
require_relative 'validation/odh_usual_work_validation_test'
require_relative 'validation/allergy_intolerance_validation_test'
require_relative 'validation/care_plan_validation_test'
require_relative 'validation/document_reference_validation_test'
require_relative 'validation/encounter_validation_test'
require_relative 'validation/medication_validation_test'
require_relative 'validation/organization_validation_test'
require_relative 'validation/patient_validation_test'
require_relative 'validation/practitioner_validation_test'
require_relative 'validation/practitioner_role_validation_test'
require_relative 'validation/procedure_validation_test'
require_relative 'validation/smokingstatus_validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class ValidationGroup < Inferno::TestGroup
      title 'Validation Tests'
      short_description ''
      description %(
  # Background

The US Core Validation sequence verifies that the system under test is
able to provide correct responses for Validation queries. These queries
must contain resources conforming to the  as
specified in the US Core v1.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:


### Search Parameters
The first search uses the selected patient(s). Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Validation resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Validation resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [](). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :ccrr_v100_validation
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'validation', 'metadata.yml'), aliases: true))
      end
      
        test from: :ccrr_v100_cancer_encounter_validation_test
        test from: :ccrr_v100_cancer_patient_validation_test
        test from: :ccrr_v100_plan_definition_validation_test
        test from: :ccrr_v100_ccrr_reporting_bundle_validation_test
        test from: :ccrr_v100_central_cancer_registry_primary_cancer_condition_validation_test
        test from: :ccrr_v100_message_header_validation_test
        test from: :ccrr_v100_us_ph_patient_validation_test
        test from: :ccrr_v100_extension_validation_test
        test from: :ccrr_v100_medication_administration_validation_test
        test from: :ccrr_v100_mcode_radiotherapy_course_summary_validation_test
        test from: :ccrr_v100_mcode_secondary_cancer_condition_validation_test
        test from: :ccrr_v100_mcode_tnm_stage_group_validation_test
        test from: :ccrr_v100_odh_usual_work_validation_test
        test from: :ccrr_v100_allergy_intolerance_validation_test
        test from: :ccrr_v100_care_plan_validation_test
        test from: :ccrr_v100_document_reference_validation_test
        test from: :ccrr_v100_encounter_validation_test
        test from: :ccrr_v100_medication_validation_test
        test from: :ccrr_v100_organization_validation_test
        test from: :ccrr_v100_patient_validation_test
        test from: :ccrr_v100_practitioner_validation_test
        test from: :ccrr_v100_practitioner_role_validation_test
        test from: :ccrr_v100_procedure_validation_test
        test from: :ccrr_v100_smokingstatus_validation_test
    end
  end
end
