require_relative 'ccrr_content_bundle/ccrr_content_bundle_must_support_test'
require_relative 'ccrr_content_bundle/ccrr_content_bundle_validation_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CcrrContentBundleGroup < Inferno::TestGroup
      title 'Bundle Central Cancer Registry Reporting Content Tests'
      short_description 'Verify support for the server capabilities required by the Central Cancer Registry Reporting Content Bundle.'
      description %(
  # Background

The US Core Bundle Central Cancer Registry Reporting Content sequence verifies that the system under test is
able to provide correct responses for Bundle queries. These queries
must contain resources conforming to the Central Cancer Registry Reporting Content Bundle as
specified in the US Core v1.0.0 Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Bundle resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [Central Cancer Registry Reporting Content Bundle](http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-content-bundle). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :ccrr_v100_ccrr_content_bundle
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'ccrr_content_bundle', 'metadata.yml'), aliases: true))
      end
      
        test from: :ccrr_v100_ccrr_content_bundle_must_support_test
        test from: :ccrr_v100_ccrr_content_bundle_validation_test
    end
  end
end
