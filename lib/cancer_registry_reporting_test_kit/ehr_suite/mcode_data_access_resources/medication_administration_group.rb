# frozen_string_literal: true

require_relative 'medication_administration/medication_administration_search_test'
require_relative 'medication_administration/medication_administration_must_support_test'
require_relative 'medication_administration/medication_administration_validation_test'

module CancerRegistryReportingTestKit
  class EHRMedicationAdministrationTests < Inferno::TestGroup
    title 'Medication Administration Search Tests'
    description %(
      Tests verify that the EHR allows apps to access patient data defined in mCode and specified
      via searches [specified by Central Cancer Registry IG v1.0.0](https://build.fhir.org/ig/HL7/fhir-central-cancer-registry-reporting-ig/spec.html#mcode-fhir-ig-usage).
      These resources are searchable by parameters defined in the [mCode IG](http://hl7.org/fhir/us/mcode/STU3/index.html).

      # Testing Methodology
      ## Searching
      This test sequence will first perform each required search associated
      with this resource. This sequence will perform searches with the
      following parameters:

      * patient + effective date

      ### Search Parameters
      The first search uses the selected patient(s). Any subsequent searches
      will look for its parameter values
      from the results of the first search. For example, the `identifier`
      search in the patient sequence is performed by looking for an existing
      `Patient.identifier` from any of the resources returned in the `_id`
      search. If a value cannot be found this way, the search is skipped.

      ### Search Validation
      Inferno will retrieve up to the first 20 bundle pages of the reply for
      Medication Administration resources and save them for subsequent tests. Each of
      these resources is then checked to see if it matches the searched
      parameters in accordance with [FHIR search
      guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
      for example, if a Patient search for `gender=male` returns a `female`
      patient.

      ## Must Support
      Each profile contains elements marked as "must support". This test
      sequence expects to see each of these elements at least once. If at
      least one cannot be found, the test will fail. The test will look
      through the Medication Administration resources found in the first test for these
      elements.

      ## Profile Validation
      Each resource returned from the first search is expected to conform to
      the [mCode Cancer-Related Medication Administration Profile](http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration).
      Each element is checked against terminology binding and cardinality requirements.

      Elements with a required binding are validated against their bound
      ValueSet. If the code/system in the element is not part of the ValueSet,
      then the test will fail.

      ## Reference Validation
      At least one instance of each external reference in elements marked as
      "must support" within the resources provided by the system must resolve.
      The test will attempt to read each reference found and will fail if no
      read succeeds.
    )

    id :ehr_medication_administration
    run_as_group

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(
                                                   File.join(__dir__, 'medication_administration',
                                                             'metadata.yml'), aliases: true
                                                 ))
    end
    test from: :medication_administration_search_test
    test from: :medication_administration_must_support_test
    test from: :medication_administration_validation_test
  end
end
