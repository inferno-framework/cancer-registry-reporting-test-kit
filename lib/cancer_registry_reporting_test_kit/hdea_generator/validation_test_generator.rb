# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module CancerRegistryReportingTestKit
  class HdeaGenerator
    class ValidationTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
            .reject { |group| SpecialCases::IGNORE_FOR_GENERATION.include?(group.profile_url) }
            .reject { |group| SpecialCases::IGNORE_FOR_VALIDATION.include?(group.profile_url) }
            .each do |group|
            new(group, base_output_dir: base_output_dir).generate
          end
        end
      end

      attr_accessor :group_metadata, :medication_request_metadata, :base_output_dir

      def initialize(group_metadata, medication_request_metadata = nil, base_output_dir:)
        self.group_metadata = group_metadata
        self.medication_request_metadata = medication_request_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'validation.rb.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, profile_identifier)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def directory_name
        Naming.snake_case_for_profile(medication_request_metadata || group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def section_name
        raw = Naming.section_for_profile_url(profile_url)&.chomp('s')
        return unless raw.present?

        if raw.include?('element')
          "referenced in the #{raw}s"
        else
          "found in the #{raw}s"
        end
      end

      def profile_url
        group_metadata.profile_url
      end

      def profile_name
        "#{group_metadata.profile_name.chomp(' Profile')} profile"
      end

      def profile_version
        group_metadata.profile_version
      end

      def profile_link
        "#{profile_url}|#{profile_version}"
      end

      def test_id
        "ccrr_#{group_metadata.reformatted_version}_#{profile_identifier}_validation_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ValidationTest"
      end

      def module_name
        "HDEA#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        read_interaction[:expectation]
      end

      def skip_if_empty
        # Return true if a system must demonstrate at least one example of the resource type.
        # This drives omit vs. skip result statuses in this test.
        resource_type != 'Medication'
      end

      def generate
        File.write(output_file_name, output)

        test_metadata = {
          id: test_id,
          file_name: base_output_file_name
        }

        # if resource_type == 'Medication'
        #   medication_request_metadata.add_test(**test_metadata)
        # else
        group_metadata.add_test(**test_metadata)
        # end
      end
    end
  end
end
