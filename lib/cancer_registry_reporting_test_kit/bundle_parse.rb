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
      '74165-2' => 'http://hl7.org/fhir/us/odh/StructureDefinition/odh-UsualWork',
      '47519-4' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure',
      '8716-3' => 'VitalSigns', #TODO: Observation has no related profile, just a resource definition...
      '29762-2' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
    }
    
    CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP = {
      '29549-3' => {'MedicationAdministration' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'},
      '10160-0' => {'MedicationAdministration' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration', 'MedicationStatement' => '#TODO', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'}, #TODO: Resolve this profile_url
      '30954-2' => {'Observation' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab', 'DiagnosticReport' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab'},
      '28650-0' => {'Document' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference', 'DiagnosticReport' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'},
      '18776-5' => {'MedicationRequest' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-request', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication', 'ServiceRequest' => '#TODO', 'CarePlan' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'},
    }
    
    FIELD_TO_URL_MAP = {
      'subject' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient',
      'encounter' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter',
      'author' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'
    }
    
    def parse_bundle(bundle)
      first_resource = bundle.entry.first.resource
      if first_resource.is_a?(FHIR::Composition)
        look_for_references_in_resource(first_resource, bundle)
      else
        puts "Error - first entry should be a Composition"
      end
    end
    
    def look_for_references_in_resource(resource, bundle)
      resource_hash = {}
      resource.to_hash.each_key do |key|
        value = resource&.send(key.to_sym)
        if value.is_a?(FHIR::Reference)
          resource_hash[FIELD_TO_URL_MAP[key]] ||= []
          referenced_resource = find_resource_in_bundle(value.reference, bundle)
          resource_hash[FIELD_TO_URL_MAP[key]] << referenced_resource if referenced_resource
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Composition::Section) }
          resource_hash.merge!(parse_sections(value, bundle))
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Reference) }
          resource_hash[FIELD_TO_URL_MAP[key]] ||= []
          value.each do |val| 
            referenced_resource = find_resource_in_bundle(val.reference, bundle)
            resource_hash[FIELD_TO_URL_MAP[key]] << referenced_resource if referenced_resource
          end
        elsif value.is_a?(FHIR::Model)
          resource_hash.merge!(look_for_references_in_resource(value, bundle))
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Model) }
          value.each { |val| resource_hash.merge!(look_for_references_in_resource(val, bundle))}
        end
      end
      resource_hash.reject { |k, v| v.nil? || v&.empty? }
    end
    
    def parse_sections(sections, bundle)
      sections.each_with_object({}) do |sec, hash|
        code = sec.code.coding.first.code
        if multiple_reference_types?(code)
          sec.entry.each do |ref|
            referenced_resource = find_resource_in_bundle(ref.reference, bundle)
            if referenced_resource
              hash[profile_from_resource_type(code, referenced_resource.resourceType)] ||= []
              hash[profile_from_resource_type(code, referenced_resource.resourceType)] << referenced_resource
            end
          end
        else
          resource_key = CODE_TO_URL_MAP[code]
          hash[resource_key] ||= []
          sec.entry.each do |ref| 
            referenced_resource = find_resource_in_bundle(ref.reference, bundle)
            hash[resource_key] << referenced_resource if referenced_resource
          end
        end
      end
    end
    
    def multiple_reference_types?(code)
      CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP.keys.include?(code)
    end
    
    # This and some surrounding logic is extremely custom fit to HDEA.  Perhaps should be split off to special cases if we mean to generalize this later.
    def profile_from_resource_type(code, resource_type)
      CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP[code][resource_type]
    end
    
    def find_resource_in_bundle(reference, bundle)
      bundle.entry.find { |res| res.resource.id == reference.split('/').last && res.resource.resourceType == reference.split('/').first }&.resource
    end
  end
end
