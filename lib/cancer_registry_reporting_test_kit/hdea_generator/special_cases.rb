# frozen_string_literal: true

module CancerRegistryReportingTestKit
  class HdeaGenerator
    module SpecialCases
      class << self
        # def move_ms_and_validation(ig_metadata)
        #   ms_group_metadata = CancerRegistryReportingTestKit::HdeaGenerator::GroupMetadata.new({name: "must_support", class_name: "MustSupportSequence", resource: "MustSupport", reformatted_version: "v100", version: "v1.0.0", title: 'Must Support'})
        #   validation_group_metadata = CancerRegistryReportingTestKit::HdeaGenerator::GroupMetadata.new({name: "must_support", class_name: "MustSupportSequence", resource: "Validation", reformatted_version: "v100", version: "v1.0.0", title: 'Validation'})
        #   ig_metadata.groups.each do |group|
        #     tests_to_delete = []
        #     group.tests.each do |test|
        #       if test[:id].include?('must_support')
        #         ms_group_metadata.add_test(id: test[:id], file_name: test[:file_name])
        #         tests_to_delete << test
        #       elsif test[:id].include?('validation')
        #         validation_group_metadata.add_test(id: test[:id], file_name: test[:file_name])
        #         tests_to_delete << test
        #       end
        #     end
        #     tests_to_delete.each { |test| group.tests.delete(test) }
        #   end
        #   ig_metadata.groups << ms_group_metadata
        #   ig_metadata.groups << validation_group_metadata
        # end
      end

      IGNORE_FOR_GENERATION = ['http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-reporting-messageheader',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-reporting-bundle',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/cancer-patient',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/cancer-encounter',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/us-ph-tribal-affiliation-extension',
                               'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-primary-cancer-condition',
                               'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-distant-metastases-category',
                               'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-primary-tumor-category',
                               'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-regional-nodes-category',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-plandefinition',
                               'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/us-ph-patient'
                              ].freeze
      IGNORE_FOR_VALIDATION = ['http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle'].freeze
    end
  end
end
