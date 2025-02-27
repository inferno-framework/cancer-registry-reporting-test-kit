require_relative 'radiotherapy_procedure/radiotherapy_procedure_must_support_test'
require_relative 'radiotherapy_procedure/radiotherapy_procedure_search_test'
require_relative 'radiotherapy_procedure/radiotherapy_procedure_validation_test'

module CancerRegistryReportingTestKit
  class RadiotherapyProcedureGroup < Inferno::TestGroup
    title 'Procedure Radiotherapy Course Summary Tests'
    short_description 'Verify support for the server capabilities required by the Radiotherapy Course Summary Profile.'
    description "
      # Background

      The US Core Procedure Radiotherapy Course Summary sequence verifies that the system under test is
      able to provide correct responses for Procedure queries. These queries
      must contain resources conforming to the Radiotherapy Course Summary Profile as
      specified in the US Core v1.0.0 Implementation Guide.

      # Testing Methodology
      ## Searching
      This test sequence will first perform each required search associated
      with this resource. This sequence will perform searches with the
      following parameters:


      ### Search Parameters
      The first search uses the selected patient(s) from the prior launch
      sequence. Any subsequent searches will look for its parameter values
      from the results of the first search. For example, the `identifier`
      search in the patient sequence is performed by looking for an existing
      `Patient.identifier` from any of the resources returned in the `_id`
      search. If a value cannot be found this way, the search is skipped.
      This search test also searches by date.  When a single date is inputted,
      the test will return any results that occurred on that date or contain
      that date within the resource's date period.

      ### Search Validation
      Inferno will retrieve up to the first 20 bundle pages of the reply for
      Procedure resources and save them for subsequent tests. Each of
      these resources is then checked to see if it matches the searched
      parameters in accordance with [FHIR search
      guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
      for example, if a Patient search for `gender=male` returns a `female`
      patient.


      ## Must Support
      Each profile contains elements marked as 'must support'. This test
      sequence expects to see each of these elements at least once. If at
      least one cannot be found, the test will fail. The test will look
      through the Procedure resources found in the first test for these
      elements.

      ## Profile Validation
      Each resource returned from the first search is expected to conform to
      the [Radiotherapy Course Summary Profile]
      (http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary).
      Each element is checked against
      teminology binding and cardinality requirements.

      Elements with a required binding are validated against their bound
      ValueSet. If the code/system in the element is not part of the ValueSet,
      then the test will fail.

      ## Reference Validation
      At least one instance of each external reference in elements marked as
      'must support' within the resources provided by the system must resolve.
      The test will attempt to read each reference found and will fail if no
      read succeeds."

    id :ehr_radiotherapy_procedure
    run_as_group

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(
        YAML.load_file(File.join(__dir__, 'radiotherapy_procedure', 'metadata.yml'), aliases: true)
      )
    end

    test from: :radiotherapy_procedure_search_test
    test from: :radiotherapy_procedure_must_support_test
    test from: :radiotherapy_procedure_validation_test
  end
end
