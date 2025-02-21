# frozen_string_literal: true

require_relative '../../../../validation_test'
require_relative '../../../../generator/naming'
require_relative '../../../../bundle_parse'
module CancerRegistryReportingTestKit
  module HDEAV100
    class CcrrContentBundleValidationTest < Inferno::Test
      include CancerRegistryReportingTestKit::ValidationTest
      include CancerRegistryReportingTestKit::HDEABundleParse

      id :ccrr_v100_ccrr_content_bundle_validation_test
      title 'Bundle resources returned during previous tests conform to the Central Cancer Registry Content Bundle profile'
      description %(
This test verifies resources returned from the first search conform to
the [Central Cancer Registry Content Bundle](http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

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
        report_hash.transform_keys { |key| :"#{Generator::Naming.snake_case_for_url(key)}_resources" }
      end

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:ccrr_content_bundle_resources] ||= {}
      end

      run do
        init_scratch
        add_ms_resources_to_scratch(JSON.parse("[#{reports}]"))
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
