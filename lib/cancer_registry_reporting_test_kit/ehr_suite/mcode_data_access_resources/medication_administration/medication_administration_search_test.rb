# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../search_test_properties'
require_relative '../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  class MedicationAdministrationSearchTest < Inferno::Test
    include CancerRegistryReportingTestKit::SearchTest

    title 'Server returns valid results for MedicationAdministration search by patient'
    description %(
        A server SHALL support searching by the
        patient search parameter on the MedicationAdministration resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.
      )

    id :ccrr_medication_administration_search_test
    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements.'

    def self.properties
      @properties ||= SearchTestProperties.new(
        first_search: true,
        resource_type: 'MedicationAdministration',
        search_param_names: %w[patient],
        test_post_search: false
      )
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:medication_administration_resources] ||= {}
    end

    run do
      run_search_test
    end
  end
end
