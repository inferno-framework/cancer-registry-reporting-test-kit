# frozen_string_literal: true

require_relative 'lib/cancer_registry_reporting_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'cancer_registry_reporting_test_kit'
  spec.version       = CancerRegistryReportingTestKit::VERSION
  spec.authors       = ['Diego Griese', 'Christine Duong', 'David Clark', 'Zachary Robin', 'Nate Cady', 'Robert Passas']
  spec.email         = ['inferno@groups.mitre.org']
  spec.summary       = 'Cancer Registry Reporting Test Kit'
  spec.description   = 'Inferno test kit for testing systems per the Central Cancer Registry IG'
  # spec.homepage      = 'TODO'
  spec.license       = 'Apache-2.0'
  spec.add_dependency 'inferno_core', '~> 0.6.8'
  spec.add_dependency 'us_core_test_kit', '~> 0.11.1'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = 'TODO'
  spec.metadata['inferno_test_kit'] = 'true'
  spec.files = `[ -d .git ] && git ls-files -z lib config/presets LICENSE`.split("\x0")

  spec.require_paths = ['lib']
end
