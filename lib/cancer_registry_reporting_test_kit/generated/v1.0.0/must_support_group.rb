require_relative 'must_support/cancer_encounter_must_support_test'
require_relative 'must_support/cancer_patient_must_support_test'
require_relative 'must_support/composition_must_support_test'
require_relative 'must_support/ccrr_content_bundle_must_support_test'
require_relative 'must_support/plan_definition_must_support_test'
require_relative 'must_support/ccrr_reporting_bundle_must_support_test'
require_relative 'must_support/central_cancer_registry_primary_cancer_condition_must_support_test'
require_relative 'must_support/message_header_must_support_test'
require_relative 'must_support/us_ph_patient_must_support_test'
require_relative 'must_support/extension_must_support_test'
require_relative 'must_support/medication_administration_must_support_test'
require_relative 'must_support/mcode_radiotherapy_course_summary_must_support_test'
require_relative 'must_support/mcode_secondary_cancer_condition_must_support_test'
require_relative 'must_support/mcode_tnm_stage_group_must_support_test'
require_relative 'must_support/odh_usual_work_must_support_test'
require_relative 'must_support/allergy_intolerance_must_support_test'
require_relative 'must_support/care_plan_must_support_test'
require_relative 'must_support/document_reference_must_support_test'
require_relative 'must_support/encounter_must_support_test'
require_relative 'must_support/medication_must_support_test'
require_relative 'must_support/organization_must_support_test'
require_relative 'must_support/patient_must_support_test'
require_relative 'must_support/practitioner_must_support_test'
require_relative 'must_support/practitioner_role_must_support_test'
require_relative 'must_support/procedure_must_support_test'
require_relative 'must_support/smokingstatus_must_support_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MustSupportGroup < Inferno::TestGroup
      title 'Must Support Tests'
      short_description ''
      description %(
  # Background

The US Core Must Support sequence verifies that the system under test is
able to provide correct responses for MustSupport queries. These queries
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
MustSupport resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the MustSupport resources found in the first test for these
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

      id :ccrr_v100_must_support
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'must_support', 'metadata.yml'), aliases: true))
      end
      
        test from: :ccrr_v100_cancer_encounter_must_support_test
        test from: :ccrr_v100_cancer_patient_must_support_test
        test from: :ccrr_v100_composition_must_support_test
        test from: :ccrr_v100_ccrr_content_bundle_must_support_test
        test from: :ccrr_v100_plan_definition_must_support_test
        test from: :ccrr_v100_ccrr_reporting_bundle_must_support_test
        test from: :ccrr_v100_central_cancer_registry_primary_cancer_condition_must_support_test
        test from: :ccrr_v100_message_header_must_support_test
        test from: :ccrr_v100_us_ph_patient_must_support_test
        test from: :ccrr_v100_extension_must_support_test
        test from: :ccrr_v100_medication_administration_must_support_test
        test from: :ccrr_v100_mcode_radiotherapy_course_summary_must_support_test
        test from: :ccrr_v100_mcode_secondary_cancer_condition_must_support_test
        test from: :ccrr_v100_mcode_tnm_stage_group_must_support_test
        test from: :ccrr_v100_odh_usual_work_must_support_test
        test from: :ccrr_v100_allergy_intolerance_must_support_test
        test from: :ccrr_v100_care_plan_must_support_test
        test from: :ccrr_v100_document_reference_must_support_test
        test from: :ccrr_v100_encounter_must_support_test
        test from: :ccrr_v100_medication_must_support_test
        test from: :ccrr_v100_organization_must_support_test
        test from: :ccrr_v100_patient_must_support_test
        test from: :ccrr_v100_practitioner_must_support_test
        test from: :ccrr_v100_practitioner_role_must_support_test
        test from: :ccrr_v100_procedure_must_support_test
        test from: :ccrr_v100_smokingstatus_must_support_test
    end
  end
end
