# frozen_string_literal: true

require_relative 'author_validation_test'
# require_relative 'author_must_support_test'
require_relative 'practitioner_must_support_test'
require_relative 'practitioner_role_must_support_test'
require_relative 'organization_must_support_test'

module CancerRegistryReportingTestKit
  module HDEAV100
    class AuthorGroup < Inferno::TestGroup
      title 'Author Tests'
      short_description 'Verify support for the Cancer Registry Report author.'
      description %(
  # Background

The Central Cancer Registry Reporting Author sequence verifies that the system under test is
able to provide a report including a valid author. An author may be represented by an organization, practitioner, or practitioner role.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Condition resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [Central Cancer Registry Reporting Primary Cancer Condition](http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-primary-cancer-condition).
 Each element is checked against terminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :ccrr_v100_author
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(
                                                     File.join(__dir__,
                                                               'central_cancer_registry_primary_cancer_condition', 'metadata.yml'), aliases: true
                                                   ))
      end

      test from: :ccrr_v100_author_validation_test
      # test from: :ccrr_v100_practitioner_must_support_test
      # test from: :ccrr_v100_practitioner_role_must_support_test
      # test from: :ccrr_v100_organization_must_support_test
    end
  end
end
