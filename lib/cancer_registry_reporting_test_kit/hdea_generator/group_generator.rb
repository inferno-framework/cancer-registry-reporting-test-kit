# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module CancerRegistryReportingTestKit
  class HdeaGenerator
    class GroupGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.ordered_groups
            .reject { |group| SpecialCases::IGNORE_FOR_GENERATION.include?(group.profile_url) }
            .each { |group| new(group, base_output_dir).generate }
        end
      end

      attr_accessor :group_metadata, :base_output_dir

      def initialize(group_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.base_output_dir = base_output_dir
      end

      def base_metadata_file_name
        'metadata.yml'
      end

      def metadata_file_name
        File.join(base_output_dir, profile_identifier, base_metadata_file_name)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def group_id
        "ccrr_#{group_metadata.reformatted_version}_#{profile_identifier}"
      end

      def generate
        FileUtils.mkdir_p(File.join(base_output_dir, profile_identifier))
        group_metadata.id = group_id
        File.write(metadata_file_name, YAML.dump(group_metadata.to_hash))
      end
    end
  end
end
