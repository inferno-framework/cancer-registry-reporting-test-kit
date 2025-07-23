# frozen_string_literal: true

require_relative 'lib/cancer_registry_reporting_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'cancer_registry_reporting_test_kit'
  spec.version       = CancerRegistryReportingTestKit::VERSION
  spec.authors       = ['Inferno Team']
  spec.summary       = 'Central Cancer Registry Reporting Test Kit'
  spec.description   = 'Inferno test kit for testing systems per the Central Cancer Registry Reporting IG'
  spec.homepage      = 'https://github.com/inferno-framework/cancer-registry-reporting-test-kit'
  spec.license       = 'Apache-2.0'
  spec.add_dependency 'inferno_core', '~> 1.0', '>= 1.0.2'
  spec.add_dependency 'smart_app_launch_test_kit', '~> 1.0'
  spec.add_dependency 'us_core_test_kit', '~> 1.0'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['inferno_test_kit'] = 'true'
  spec.files = `[ -d .git ] && git ls-files -z lib config/presets LICENSE`.split("\x0")

  spec.require_paths = ['lib']
end
