require_relative '../../../../must_support_test'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class OdhUsualWorkMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Odh Usual Work resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.component:odh-UsualIndustry.value[x].coding
        * Observation.component:odh-UsualIndustry.value[x].coding:industryCDCCensus2010
        * Observation.component:odh-UsualIndustry.value[x].coding:industryONETSOCDetailODH
        * Observation.value[x]:valueCodeableConcept
        * Observation.value[x]:valueCodeableConcept.coding
        * Observation.value[x]:valueCodeableConcept.coding:occupationCDCCensus2010
        * Observation.value[x]:valueCodeableConcept.coding:occupationONETSOCDetailODH
      )

      id :ccrr_v100_odh_usual_work_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:odh_usual_work_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
