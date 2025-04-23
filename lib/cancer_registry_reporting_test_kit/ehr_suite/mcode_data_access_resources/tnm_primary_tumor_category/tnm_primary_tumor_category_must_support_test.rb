# frozen_string_literal: true

require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class TNMPrimaryTumorCategoryMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the TNM Primary Tumor Category Observation resources returned'
    description %(
      CCRR EHRs SHALL be capable of populating all data elements as
      part of the query results. This test will look through the Observation resources
      found previously for the following must support elements:

      * Observation.category
      * Observation.code
      * Observation.effective[x]
      * Observation.focus
      * Observation.method
      * Observation.performer
      * Observation.status
      * Observation.subject
      * Observation.value[x]
    )

    id :ccrr_tnm_primary_tumor_category_must_support_test

    def resource_type
      'Observation'
    end

    def self.metadata
      @metadata ||= HdeaGenerator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:tnm_primary_tumor_category_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
