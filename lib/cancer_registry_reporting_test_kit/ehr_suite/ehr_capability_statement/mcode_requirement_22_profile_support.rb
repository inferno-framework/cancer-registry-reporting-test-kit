# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Layout/HeredocIndentation
module CancerRegistryReportingTestKit
  class AttestationTestMcodeRequirement22 < Inferno::Test
    title 'Listing Profiles'
    description <<~DESCRIPTION
Attest that the following [mCode](https://hl7.org/fhir/us/mcode/STU3/index.html) [requirement](https://hl7.org/fhir/us/mcode/STU3/conformance-profiles.html#profile-level-conformance-expectations) is met:

>The list of implemented profiles SHALL be published in a CapabilityStatement.
    DESCRIPTION
    id :mcode_requirement_22_profile_support

    uses_request :capability_statement
    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      supported_profiles = capability_statement.rest&.flat_map do |rest|
        rest.resource.flat_map do |resource|
          # Remove trailing version from canonical url
          resource.supportedProfile&.map { |profile| profile.split('|').first }
        end.compact
      end&.uniq || []

      required_profiles = config.options[:required_profiles]

      missing_profiles = required_profiles - supported_profiles

      missing_profiles_list =
          missing_profiles
            .map { |resource| "`#{resource}`" }
            .join(', ')

        assert missing_profiles.empty?,
               'The CapabilityStatement does not list support for the following' \
               "profiles: #{missing_profiles_list}"

      
    end
  end
end
# rubocop:enable Layout/HeredocIndentation
# rubocop:enable Lint/RedundantCopDisableDirective
