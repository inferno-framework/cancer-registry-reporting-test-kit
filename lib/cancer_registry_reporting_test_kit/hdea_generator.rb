# frozen_string_literal: true

require 'fhir_models'
require 'inferno/ext/fhir_models'

require_relative 'hdea_generator/ig_loader'
require_relative 'hdea_generator/ig_metadata_extractor'
require_relative 'hdea_generator/group_generator'
require_relative 'hdea_generator/must_support_test_generator'
require_relative 'hdea_generator/validation_test_generator'
require_relative 'hdea_generator/special_cases'

module CancerRegistryReportingTestKit
  class HdeaGenerator
    def self.generate
      ig_packages = Dir.glob(File.join(Dir.pwd, 'lib', 'cancer_registry_reporting_test_kit', 'igs', '*.tgz'))

      ig_packages.each do |ig_package|
        new(ig_package).generate
      end
    end

    attr_accessor :ig_resources, :ig_metadata, :ig_file_name

    def initialize(ig_file_name)
      self.ig_file_name = ig_file_name
    end

    def generate
      puts "Generating tests for IG #{File.basename(ig_file_name)}"
      load_ig_package
      extract_metadata
      generate_must_support_tests
      generate_validation_tests
      generate_groups
    end

    def extract_metadata
      self.ig_metadata = IGMetadataExtractor.new(ig_resources).extract

      FileUtils.mkdir_p(base_output_dir)
    end

    def base_output_dir
      File.join(__dir__, 'hdea_suite', 'generated', ig_metadata.ig_version)
    end

    def load_ig_package
      FHIR.logger = Logger.new(File::NULL)
      self.ig_resources = IGLoader.new(ig_file_name).load
    end

    def generate_validation_tests
      ValidationTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_must_support_tests
      MustSupportTestGenerator.generate(ig_metadata, base_output_dir)
    end

    def generate_groups
      # SpecialCases.move_ms_and_validation(ig_metadata)
      GroupGenerator.generate(ig_metadata, base_output_dir)
    end
  end
end
