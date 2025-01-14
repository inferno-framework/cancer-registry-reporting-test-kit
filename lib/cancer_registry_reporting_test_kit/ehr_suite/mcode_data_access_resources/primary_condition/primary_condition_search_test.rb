require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
    class PrimaryConditionSearchTest < Inferno::Test
      include CancerRegistryReportingTestKit::SearchTest

      title 'Server returns valid results for Primary Condition search by patient + category'
      description %(
        A server SHALL support searching by
        patient + category on the Condition resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.

        [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-server.html)

      )

      id :primary_condition_search_test
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
      
      input :primary_condition_category,
        title: 'Category of primary condition'

      def self.properties
          @properties ||= USCoreTestKit::SearchTestProperties.new(
          first_search: true,
          fixed_value_search: true,
          resource_type: 'Condition',
          search_param_names: ['patient', 'category'],
          possible_status_search: true,
          token_search_params: ['category'],
          test_reference_variants: true,
          test_post_search: true
          )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end
      
      def scratch_resources
        scratch[:primary_condition_resources] ||= {}
      end

      run do
        run_search_test
      end
      
    end
  end