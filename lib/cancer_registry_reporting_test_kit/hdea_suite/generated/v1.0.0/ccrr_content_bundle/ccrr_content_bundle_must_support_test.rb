require_relative '../../../../must_support_test'
require_relative '../../../../generator/naming'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CcrrContentBundleMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the CCRR Content Bundle resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry:composition
        * Bundle.entry:composition.resource
      )

      id :ccrr_v100_ccrr_content_bundle_must_support_test

      def init_scratch
        scratch ||= {}
      end

      def add_ms_resources_to_scratch(reports)
        reports.each do |bundle|
          report_hash = url_keys_to_group_keys(parse_bundle(FHIR.from_contents(bundle.to_json)).first) # taking the reports out of the bundles and parsing them
          report_hash.each do |group, resources|
            scratch[group] ||= {}
            scratch[group][:all] ||= []
            scratch[group][:all].concat(resources)
          end
        end
      end

      def url_keys_to_group_keys(report_hash)
        report_hash.transform_keys { |key| "#{Generator::Naming.snake_case_for_url(key)}_resources".to_sym}
      end

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__,'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:ccrr_content_bundle_resources] ||= {}
      end

      run do
        init_scratch
        add_ms_resources_to_scratch(JSON.parse("[" + reports + "]"))
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
