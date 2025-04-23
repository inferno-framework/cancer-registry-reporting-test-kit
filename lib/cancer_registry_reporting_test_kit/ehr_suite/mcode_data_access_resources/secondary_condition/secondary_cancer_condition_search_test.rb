# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  class SecondaryCancerConditionSearchTest < Inferno::Test
    include CancerRegistryReportingTestKit::SearchTest

    title 'Server returns valid results for Condition search by patient + category'
    description %(
        A server SHALL support searching by
        patient + category on the Condition resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.

        [CCRR Capability Statement](https://hl7.org/fhir/us/central-cancer-registry-reporting/STU1/CapabilityStatement-central-cancer-registry-reporting-ehr.html)

        [mCODE Query Support](https://hl7.org/fhir/us/mcode/conformance-general.html#support-querying-mcode-conforming-resources)

      )

    id :ccrr_secondary_cancer_condition_search_test
    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements.'

    input :secondary_condition_category,
          title: 'Secondary Cancer Condition category',
          description: %(
            `Condition.category` value that distinguishes Secondary Cancer Condition instances. Used as a search
            parameter value when searching to identify Condition instances to check for conformance to the Secondary
            Cancer Condition profile.
          ),
          optional: true

    def self.properties
      @properties ||= USCoreTestKit::SearchTestProperties.new(
        first_search: true,
        resource_type: 'Condition',
        search_param_names: %w[patient category],
        test_post_search: true
      )
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:secondary_condition_resources] ||= {}
    end

    run do
      skip_if secondary_condition_category.blank?,
              'Provide a cateogry search value for Secondary Cancer Conditions in the ' \
              '**Secondary Cancer Condition category** input to run these tests.'

      # manual params must be in the same order as the param names
      @manual_search_params = [secondary_condition_category]
      run_search_test
    end
  end
end
