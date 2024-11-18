require_relative 'fhir_resource_navigation'

module CancerRegistryReportingTestKit
  module HDEABundleParse
    extend Forwardable
    include FHIRResourceNavigation

    CODE_TO_URL_MAP = {
      '363346000' => 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-primary-cancer-condition',
      '128462008' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition',
      '21908-9' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-stage-group',
      '1217123003' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary' ,
      '11450-4' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition',
      '48765-2' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance',
      '29549-3' => 'Medications Administered Section',
      '10160-0' => 'Medication Section',
      '74165-2' => 'http://hl7.org/fhir/us/odh/StructureDefinition/odh-UsualWork',
      '30954-2' => 'Results Section',
      '28650-0' => 'Notes',
      '18776-5' => 'PlanOfTreatment',
      '47519-4' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure',
      '8716-3' => 'VitalSigns', #TODO: Observation has no related profile, just a resource definition...
      '29762-2' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
    }
    
    FIELD_TO_URL_MAP = {
      'subject' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient',
      'encounter' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter',
      'author' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'
    }
    
    def parse_bundle(bundle)
      first_resource = bundle.entry.first.resource
      if first_resource.is_a?(FHIR::Composition)
        look_for_references_in_resource(first_resource, bundle).each { |k,v| puts "#{k} ---> #{v}\n\n"}
      else
        puts "Error - first entry should be a Composition"
      end
    end
    
    def look_for_references_in_resource(resource, bundle)
      resource_hash = {}
        resource.to_hash.each_key do |k|
          value = resource.send(k.to_sym)
          if value.is_a?(FHIR::Reference)
            resource_hash[FIELD_TO_URL_MAP[k]] = find_resource_in_bundle(value.reference, bundle)
          elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Composition::Section) }
            resource_hash.merge!(parse_sections(value, bundle))
          elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Reference) }
            resource_hash[FIELD_TO_URL_MAP[k]] ||= []
            value.each { |val| resource_hash[FIELD_TO_URL_MAP[k]] << find_resource_in_bundle(val.reference, bundle)}
          elsif value.is_a?(FHIR::Model)
            resource_hash.merge!(look_for_references_in_resource(value, bundle))
          elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Model) }
            value.each { |val| resource_hash.merge!(look_for_references_in_resource(val, bundle))}
          end
        end
      resource_hash
    end
    
    def parse_sections(sections, bundle)
      sections.each_with_object({}) do |sec, hash|
        hash[CODE_TO_URL_MAP[sec.code.coding.first.code]] ||= []
        sec.entry.each do |ref| 
          referenced_resource = find_resource_in_bundle(ref.reference, bundle)
          # validation_result = validate(referenced_resource)
          binding.pry
          hash[CODE_TO_URL_MAP[sec.code.coding.first.code]] << referenced_resource if referenced_resource
        end
      end
    end
    
    def find_resource_in_bundle(reference, bundle)
      bundle.entry.find { |res| res.resource.id == reference.split('/').last && res.resource.resourceType == reference.split('/').first }&.resource
    end
  end
end
