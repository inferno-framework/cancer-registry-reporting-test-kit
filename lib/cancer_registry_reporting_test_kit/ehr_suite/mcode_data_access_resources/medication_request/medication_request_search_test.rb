# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  class MedicationRequestSearchTest < Inferno::Test
    include CancerRegistryReportingTestKit::SearchTest

    title 'Server returns valid results for MedicationRequest search by patient + intent (order)'
    description %(
        A server SHALL support searching by
        patient + intent search parameters on on the MedicationRequest resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.
      )

    id :ccrr_medication_request_search_test
    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements.'

    def self.properties
      @properties ||= USCoreTestKit::SearchTestProperties.new(
        first_search: true,
        fixed_value_search: true,
        resource_type: 'MedicationRequest',
        search_param_names: %w[patient intent],
        possible_status_search: true,
        test_medication_inclusion: true,
        test_reference_variants: true,
        multiple_or_search_params: ['intent'],
        test_post_search: false
      )
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:medication_request_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
