require_relative '../../../search_test'
require_relative '../../../search_test_properties'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
    class MedicationAdministrationSearchTest < Inferno::Test
      include CancerRegistryReportingTestKit::SearchTest

      title 'Server returns valid results for Medication Administration search by patient + date range'
      description %(
        A server SHALL support searching by
        patient + date range on the MedicationAdministration resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.

        Because this is the first search of the sequence, resources in the
        response will be used for subsequent tests.

        Additionally, this test will check that GET and POST search methods
        return the same number of results.

        [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-server.html)

      )

      id :medication_administration_search_test
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
      
      input :medication_administration_effective_date,
        title: 'Effective date of Medication Administration'

      def self.properties
          @properties ||= SearchTestProperties.new(
          first_search: true,
          resource_type: 'MedicationAdministration',
          search_param_names: ['patient', 'effective-time'],
          test_post_search: true
          )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end
      
      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        # manual params must be in the same order as the param names
        @manual_search_params = [medication_administration_effective_date]
        run_search_test
      end
      
    end
  end