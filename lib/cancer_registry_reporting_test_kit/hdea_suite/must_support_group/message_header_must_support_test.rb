require_relative '../../must_support_test'
require_relative '../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class MessageHeaderMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the MessageHeader resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the MessageHeader resources
        found previously for the following must support elements:

        * MessageHeader.definition
        * MessageHeader.destination
        * MessageHeader.destination.endpoint
        * MessageHeader.event[x]
        * MessageHeader.extension
        * MessageHeader.extension:dataEncrypted
        * MessageHeader.extension:reportInitiationType
        * MessageHeader.reason
        * MessageHeader.response
        * MessageHeader.response.code
        * MessageHeader.response.details
        * MessageHeader.response.identifier
        * MessageHeader.sender
        * MessageHeader.source
        * MessageHeader.source.endpoint
        * MessageHeader.source.name
        * MessageHeader.source.software
        * MessageHeader.source.version
      )

      id :ccrr_v100_message_header_must_support_test

      def resource_type
        'MessageHeader'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', '..', 'generated', 'v1.0.0', 'message_header', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:message_header_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
