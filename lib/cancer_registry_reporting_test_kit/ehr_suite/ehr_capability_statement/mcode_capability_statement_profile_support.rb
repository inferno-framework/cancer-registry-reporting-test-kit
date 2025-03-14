# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Layout/HeredocIndentation
module CancerRegistryReportingTestKit
  class MCodeCapabilityStatementProfileSupport < Inferno::Test
    title 'Capability Statement lists support for required mCode Profiles'
    description <<~DESCRIPTION
    This test verifies that the list of implemented profiles required by the Cancer Registry IG (link) SHALL be published in the returned CapbilityStatement.
    DESCRIPTION
    id :mcode_capability_statement_profile_support

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
