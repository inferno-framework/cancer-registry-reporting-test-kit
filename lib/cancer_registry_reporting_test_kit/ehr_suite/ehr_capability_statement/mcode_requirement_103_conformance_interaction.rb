# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Layout/HeredocIndentation
module CancerRegistryReportingTestKit
  class AttestationTestMcodeRequirement103 < Inferno::Test
    title 'FHIR Server supports the conformance interaction'
    description <<~DESCRIPTION
      This test checks the following SHALL requirement:
      > The CapabilityStatement SHALL be returned in response to a GET [base]/metadata request.

      It does this by checking that the server responds with an HTTP OK 200
      status code and that the body of the response contains a valid
      [CapabilityStatement
      resource](http://hl7.org/fhir/R4/capabilitystatement.html). This test
      does not inspect the content of the CapabilityStatement to see if it
      contains the required information. It only checks to see if the RESTful
      interaction is supported and returns a valid CapabilityStatement
      resource.
    DESCRIPTION
    id :mcode_requirement_103_conformance_interaction

    makes_request :capability_statement
    
    run do
      fhir_client
      fhir_get_capability_statement(name: :capability_statement)

      assert_response_status(200)
      assert_resource_type(:capability_statement)
      assert_valid_resource
    end
  end
end
# rubocop:enable Layout/HeredocIndentation
# rubocop:enable Lint/RedundantCopDisableDirective
