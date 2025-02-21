# frozen_string_literal: true

require_relative '../../../must_support_test'

module CancerRegistryReportingTestKit
  class TNMStageGroupMustSupportTest < Inferno::Test
    include CancerRegistryReportingTestKit::MustSupportTest

    title 'All must support elements are provided in the TNM Stage Group resources returned'
    description %(
      )

    id :tnm_stage_group_must_support_test

    def resource_type
      'Observation'
    end

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
    end

    def scratch_resources
      scratch[:tnm_stage_group_resources] ||= {}
    end

    run do
      perform_must_support_test(all_scratch_resources)
    end
  end
end
