require_relative '../../must_support_test'
require_relative '../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class OrganizationMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Organization resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Organization resources
        found previously for the following must support elements:

        * Organization.active
        * Organization.address
        * Organization.address.city
        * Organization.address.country
        * Organization.address.line
        * Organization.address.postalCode
        * Organization.address.state
        * Organization.identifier
        * Organization.identifier.system
        * Organization.identifier.value
        * Organization.identifier:NPI
        * Organization.name
        * Organization.telecom
        * Organization.telecom.system
        * Organization.telecom.value
      )

      id :ccrr_v100_organization_must_support_test

      def resource_type
        'Organization'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'organization_metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:author_resources] ||= {}
      end

      run do
        AUTHOR_PROFILES = {
          'PractitionerRole' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole',
          'Practitioner' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner',
          'Organization' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'
        }

        resources_by_type = {
          'PractitionerRole' => [],
          'Practitioner' => [],
          'Organization' => []
        }

        scratch_resources.each do |author|
          resources_by_type[author.resourceType] << author
        end

        skip if resources_by_type['Practitioner'].empty? && resources_by_type['PractitionerRole'].empty? && resources_by_type['Organization'].empty?
        omit if resources_by_type['Organization'].empty?
        perform_must_support_test(resources_by_type['Organization'])
      end
    end
  end
end
