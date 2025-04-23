# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../hdea_generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class ServiceRequestMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'Base ServiceRequest profile must support element coverage'
      description %(
        This test looks across all instances
        associated with the [Base ServiceRequest profile](http://hl7.org/fhir/StructureDefinition/ServiceRequest|4.0.1)
        found in the provided report Bundles and verifies that they
        contain populated examples of the following must support elements
        defined in the profile:


      )

      id :ccrr_v100_service_request_must_support_test

      def resource_type
        'ServiceRequest'
      end

      def self.metadata
        @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
