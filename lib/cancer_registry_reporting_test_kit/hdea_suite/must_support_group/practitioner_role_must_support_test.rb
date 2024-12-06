require_relative '../../must_support_test'
require_relative '../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class PractitionerRoleMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the PractitionerRole resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the PractitionerRole resources
        found previously for the following must support elements:

        * PractitionerRole.code
        * PractitionerRole.endpoint
        * PractitionerRole.location
        * PractitionerRole.organization
        * PractitionerRole.practitioner
        * PractitionerRole.specialty
        * PractitionerRole.telecom
        * PractitionerRole.telecom.system
        * PractitionerRole.telecom.value
      )

      id :ccrr_v100_practitioner_role_must_support_test

      def resource_type
        'PractitionerRole'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', '..', 'generated', 'v1.0.0', 'practioner_role', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
