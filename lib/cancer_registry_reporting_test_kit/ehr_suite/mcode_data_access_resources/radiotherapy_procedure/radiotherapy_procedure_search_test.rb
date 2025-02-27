require_relative '../../../search_test'
require_relative '../../../search_test_properties'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  class RadiotherapyProcedureSearchTest < Inferno::Test
    include CancerRegistryReportingTestKit::SearchTest

    title 'Server returns valid results for Radiotherapy Procedure search by patient'
    description "
        A server SHALL support searching by
        patient on the Procedure resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.

        [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-server.html)

      "

    id :radiotherapy_procedure_search_test
    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    input :radiotherapy_procedure_performed_date,
          title: 'Performed date of Radiotherapy Procedure'

    def self.properties
      @properties ||= SearchTestProperties.new(
        first_search: true,
        resource_type: 'Procedure',
        search_param_names: ['patient', 'date'],
        test_post_search: false
      )
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:radiotherapy_procedure_resources] ||= {}
    end

    run do
      # manual params must be in the same order as the param names
      @manual_search_params = [radiotherapy_procedure_performed_date, 'mcode-radiotherapy-course-summary']
      run_search_test
    end
  end
end
