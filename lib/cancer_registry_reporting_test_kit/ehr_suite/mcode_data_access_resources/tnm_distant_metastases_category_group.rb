# frozen_string_literal: true

require_relative 'tnm_distant_metastases_category/tnm_distant_metastases_category_search_test'
require_relative 'tnm_distant_metastases_category/tnm_distant_metastases_category_must_support_test'
require_relative 'tnm_distant_metastases_category/tnm_distant_metastases_category_validation_test'

module CancerRegistryReportingTestKit
  class EHRTNMDistantMetastasesCategoryTests < Inferno::TestGroup
    title 'TNM Distant Metastases Category Search Tests'
    description %(
        Tests verify that the EHR allows apps to access patient data defined in mCode and specified
        via searches [specified by Central Cancer Registry IG v1.0.0](https://build.fhir.org/ig/HL7/fhir-central-cancer-registry-reporting-ig/spec.html#mcode-fhir-ig-usage).
        These resources are searchable by parameters defined in the [mCode IG](http://hl7.org/fhir/us/mcode/STU3/index.html).
            )
    id :ehr_tnm_distant_metastases_category
    run_as_group

    def self.metadata
      @metadata ||= Generator::GroupMetadata.new(YAML.load_file(
                                                   File.join(__dir__, 'tnm_distant_metastases_category',
                                                             'metadata.yml'), aliases: true
                                                 ))
    end
    test from: :tnm_distant_metastases_category_search_test
    test from: :tnm_distant_metastases_category_must_support_test
    test from: :tnm_distant_metastases_category_validation_test
  end
end
