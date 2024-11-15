require_relative 'fhir_resource_navigation'

module CancerRegistryReportingTestKit
  module HDEABundleParse
    extend Forwardable
    include FHIRResourceNavigation

    def parse_bundle(bundle)
      first_entry = bundle.entry.first
      if first_entry.is_a?(FHIR::Composition)
        puts "No Error"
      else
        puts "Error - first entry should be a Composition"
      end
    end
  end
end
