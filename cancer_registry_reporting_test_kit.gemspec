# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'cancer_registry_reporting_test_kit'
  spec.version       = '0.0.1'
  spec.authors       = ['Diego Griese', 'Christine Duong', 'David Clark', 'Zachary Robin', 'Nate Cady', 'Robert Passas']
  # spec.email         = ['TODO']
  spec.summary       = 'Cancer Registry Reporting Test Kit'
  spec.description   = 'Inferno test kit for testing systems per the Central Cancer Registry IG'
  # spec.homepage      = 'TODO'
  spec.license       = 'Apache-2.0'
  spec.add_dependency 'inferno_core', '~> 0.6.4'
  spec.add_dependency 'us_core_test_kit'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  # spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = 'TODO'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
