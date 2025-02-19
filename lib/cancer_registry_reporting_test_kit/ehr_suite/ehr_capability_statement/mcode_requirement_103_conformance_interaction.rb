# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Layout/HeredocIndentation
module CancerRegistryReportingTestKit
  class AttestationTestMcodeRequirement103 < Inferno::Test
    title 'FHIR Server supports the conformance interaction'
    description <<~DESCRIPTION
Attest that the following [mCode](https://hl7.org/fhir/us/mcode/STU3/index.html) [requirement](https://hl7.org/fhir/us/mcode/STU3/conformance-general.html#publish-a-capabilitystatement-identifying-supported-profiles-and-operations) is met:

>The CapabilityStatement SHALL be returned in response to a GET [base]/metadata request.
    DESCRIPTION
    id :mcode_requirement_103_conformance_interaction

    makes_request :capability_statement
    
    run do
      fhir_client.set_no_auth
      fhir_get_capability_statement(name: :capability_statement)

      assert_response_status(200)
      assert_resource_type(:capability_statement)
      assert_valid_resource
    end
  end
end
# rubocop:enable Layout/HeredocIndentation
# rubocop:enable Lint/RedundantCopDisableDirective
