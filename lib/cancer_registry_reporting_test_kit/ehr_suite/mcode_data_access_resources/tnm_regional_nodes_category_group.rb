# frozen_string_literal: true

require_relative 'tnm_regional_nodes_category/tnm_regional_nodes_category_search_test'
require_relative 'tnm_regional_nodes_category/tnm_regional_nodes_category_must_support_test'
require_relative 'tnm_regional_nodes_category/tnm_regional_nodes_category_validation_test'

module CancerRegistryReportingTestKit
  class EHRTNMRegionalNodeasCategoryTests < Inferno::TestGroup
    title 'mCODE TNM Regional Nodes Category'
    description %(
      # Background
      The mCODE TNM Regional Nodes Category group verifies that the system under test is
      able to provide correct responses for mCODE TNM Regional Nodes Category Observation queries. These queries
      return resources conforming to the [mCODE TNM Regional Nodes Category Profile](https://hl7.org/fhir/us/mcode/STU3/StructureDefinition-mcode-tnm-regional-nodes-category.html)
      as specified in the mCODE v3.0.0 Implementation Guide.

      # Testing Methodology
      ## Searching
      This test sequence will first perform each required search associated
      with this resource. This sequence will perform searches with the
      following parameters:

      * patient + code

      ### Search Parameters
      The first search uses values from the **Patient IDs** and
      **TNM Regional Nodes Category code** inputs as provided by the tester.
      Any subsequent searches will look for its parameter values
      from the results of the first search. For example, the `identifier`
      search in the patient sequence is performed by looking for an existing
      `Patient.identifier` from any of the resources returned in the first
      search. If a value cannot be found this way, the search is skipped.

      ### Search Validation
      Inferno will retrieve up to the first 20 bundle pages of the reply for
      Observation resources and save them for subsequent tests. Each of
      these resources is then checked to see if it matches the searched
      parameters in accordance with [FHIR search
      guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
      for example, if a Patient search for `gender=male` returns a `female`
      patient.


      ## Must Support
      Each profile contains elements marked as "must support". This test
      sequence expects to see each of these elements at least once. If at
      least one cannot be found, the test will fail. The test will look
      through the Observation resources found in the first test for these
      elements.

      ## Profile Validation
      Each resource returned from the first search is expected to conform to
      the [mCODE TNM Regional Nodes Category Profile](https://hl7.org/fhir/us/mcode/STU3/StructureDefinition-mcode-tnm-regional-nodes-category.html).
      Each element is checked against terminology binding and cardinality requirements.

      Elements with a required binding are validated against their bound
      ValueSet. If the code/system in the element is not part of the ValueSet,
      then the test will fail.
    )
    id :ccrr_ehr_tnm_regional_nodes_category
    run_as_group

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(
                                                       File.join(__dir__, 'tnm_regional_nodes_category',
                                                                 'metadata.yml'), aliases: true
                                                     ))
    end
    test from: :ccrr_tnm_regional_nodes_category_search_test
    test from: :ccrr_tnm_regional_nodes_category_validation_test
    test from: :ccrr_tnm_regional_nodes_category_must_support_test
  end
end
