# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cancer_registry_reporting_test_kit'
  spec.version       = '0.0.1'
  spec.authors       = ['Inferno Template']
  # spec.email         = ['TODO']
  spec.summary       = 'Cancer Registry Reporting Test Kit'
  spec.description   = 'Inferno test kit for testing systems per the Central Cancer Registry IG'
  # spec.homepage      = 'TODO'
  spec.license       = 'Apache-2.0'
  spec.add_dependency 'inferno_core', '~> 0.6.4'
  spec.add_dependency 'us_core_test_kit'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3')
  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = 'TODO'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
