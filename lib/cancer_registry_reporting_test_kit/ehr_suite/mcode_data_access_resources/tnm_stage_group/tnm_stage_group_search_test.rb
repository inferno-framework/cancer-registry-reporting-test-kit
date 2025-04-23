# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  class TNMStageGroupSearchTest < Inferno::Test
    include CancerRegistryReportingTestKit::SearchTest

    title 'Server returns valid results for Observation search by patient + code'
    description %(
        A server SHALL support searching by
        patient + code on the Observation resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.
      )

    id :ccrr_tnm_stage_group_search_test
    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    input :tnm_stage_group_code,
          title: 'TNM Stage Group code',
          description: %(
            `Observation.code` value that distinguishes TNM Stage Group instances from other Observations. Used as
            a search parameter value when searching for Observation instances to check for conformance to the
            TNM Stage Group Observation profile.
          ),
          optional: true

    def self.properties
      @properties ||= CancerRegistryReportingTestKit::SearchTestProperties.new(
        first_search: true,
        fixed_value_search: false,
        resource_type: 'Observation',
        search_param_names: %w[patient code],
        possible_status_search: true,
        token_search_params: ['code'],
        test_reference_variants: true,
        test_post_search: false
      )
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:tnm_stage_group_resources] ||= {}
    end

    run do
      skip_if tnm_stage_group_code.blank?,
              'Provide a code search value for TNM Stage Groups in the ' \
              '**TNM Stage Group code** input to run these tests.'

      # manual params must be in the same order as the param names
      @manual_search_params = [tnm_stage_group_code]
      run_search_test
    end
  end
end
