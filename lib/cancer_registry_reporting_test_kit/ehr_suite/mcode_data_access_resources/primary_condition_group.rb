require_relative './primary_condition/primary_condition_search_test'
require_relative './primary_condition/primary_condition_must_support_test'
require_relative './primary_condition/primary_condition_validation_test'

module CancerRegistryReportingTestKit
  class EHRPrimaryConditionTests < Inferno::TestGroup
    title 'Primary Condition Search Tests'
    description %(
        Tests verify that the EHR allows apps to access patient data defined in mCode and specified
        via searches [specified by Central Cancer Registry IG v1.0.0](https://build.fhir.org/ig/HL7/fhir-central-cancer-registry-reporting-ig/spec.html#mcode-fhir-ig-usage).
        These resources are searchable by parameters defined in the [mCode IG](http://hl7.org/fhir/us/mcode/STU3/index.html).
            )
      id :ehr_primary_condition     
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'primary_condition', 'metadata.yml'), aliases: true))
      end
      test from: :primary_condition_search_test
      test from: :primary_condition_must_support_test
      test from: :primary_condition_validation_test
      end
end