require_relative 'fhir_resource_navigation'

module CancerRegistryReportingTestKit
  module HDEABundleParse
    extend Forwardable
    include FHIRResourceNavigation

    # Much of this is extremely custom fit to HDEA.  
    # HDEA Custom Components:
    # - CODE_TO_URL_MAP, CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP, FIELD_TO_URL_MAP are nongenerated mappings specific to HDEA.
    # - The `profile_from_resource_type()` method similarly assumes decisions between profiles are made via code. This is NOT what the IG suggests (instead verify by profile)
    # - The `parse_bundle()` method assumes the bundle is a content bundle for hdea and thus starts with a composition resource. It also immediately yields unresolved references as an info message
    # - The `look_for_references_in_resource()` method was designed to be flexible but with HDEA CCRR as the grounds for inspiration. It has not been tested on other bundles that include a composition.
    # - Assumes references are of the form `ResourceType/ID` 

    def unresolved_references
      @unresolved_references ||= []
    end

    def clear_unresolved_references
      @unresolved_references = []
    end

    CODE_TO_URL_MAP = {
      '363346000' => 'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-primary-cancer-condition',
      '128462008' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition',
      '21908-9' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-stage-group',
      '1217123003' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary' ,
      '11450-4' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition',
      '48765-2' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance',
      '74165-2' => 'http://hl7.org/fhir/us/odh/StructureDefinition/odh-UsualWork',
      '47519-4' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure',
      '8716-3' => 'http://hl7.org/fhir/StructureDefinition/Observation',
      '29762-2' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus'
    }
    
    CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP = {
      '29549-3' => {'MedicationAdministration' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'},
      '10160-0' => {'MedicationAdministration' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration', 'MedicationStatement' => 'http://hl7.org/fhir/StructureDefinition/MedicationStatement', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'},
      '30954-2' => {'Observation' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab', 'DiagnosticReport' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab'},
      '28650-0' => {'Document' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference', 'DiagnosticReport' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'},
      '18776-5' => {'MedicationRequest' => 'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-request', 'Medication' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication', 'ServiceRequest' => 'http://hl7.org/fhir/StructureDefinition/ServiceRequest', 'CarePlan' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'},
    }
    
    FIELD_TO_URL_MAP = {
      'subject' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient',
      'encounter' => 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter',
      'author' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole', 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner', 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization']
    }

    
    PROFILE_TO_RESOURCE_KEY_MAP = {
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance' => :allergy_intolerance_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/cancer-encounter' => :cancer_encounter_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/cancer-patient' => :cancer_patient_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan' => :care_plan_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-reporting-bundle' => :ccrr_reporting_bundle_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-primary-cancer-condition' => :central_cancer_registry_primary_cancer_condition_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference' => :document_reference_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter' => :encounter_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/us-ph-tribal-affiliation-extension' => :extension_resources,
      'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-radiotherapy-course-summary' => :mcode_radiotherapy_course_summary_resources,
      'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-secondary-cancer-condition'=> :mcode_secondary_cancer_condition_resources,
      'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-tnm-stage-group' => :mcode_tnm_stage_group_resources,
      'http://hl7.org/fhir/us/mcode/StructureDefinition/mcode-cancer-related-medication-administration' => :medication_administration_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication' => :medication_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/central-cancer-registry-reporting-messageheader' => :message_header_resources,
      'http://hl7.org/fhir/us/odh/StructureDefinition/odh-UsualWork' => :odh_usual_work_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization' => :organization_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'=> :patient_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/ccrr-plandefinition' => :plan_definition_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole' => :practitioner_role_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner' => :practitioner_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure' => :procedure_resources,
      'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus' => :smokingstatus_resources,
      'http://hl7.org/fhir/us/central-cancer-registry-reporting/StructureDefinition/us-ph-patient' => :us_ph_patient_resources,
      FIELD_TO_URL_MAP['author'] => :author_resources
    }

    # Method for translating received bundle into a hash of resources.  Use for MS and Validation testing
    def parse_bundle(bundle)
      first_resource = bundle.entry.first.resource
      if first_resource.is_a?(FHIR::Composition)
        parsed_bundle = look_for_references_in_resource(first_resource, bundle)
        if !unresolved_references.empty?
          info "The following references did not resolve, the resources either do not exist in the bundle or are mislabeled: #{unresolved_references}"
        end
        current_bundle_unresolved_references = unresolved_references
        clear_unresolved_references
        return parsed_bundle, current_bundle_unresolved_references
      else
        puts 'Error - first entry should be a Composition'
      end
    end
    
    # Helpers
    def look_for_references_in_resource(resource, bundle)
      resource_hash = {}
      resource.to_hash.each_key do |key|
        value = resource&.send(key.to_sym)
        if value.is_a?(FHIR::Reference)
          resource_hash[FIELD_TO_URL_MAP[key]] ||= []
          referenced_resource = find_resource_in_bundle(value.reference, bundle)
          unresolved_references << value.reference if !referenced_resource
          resource_hash[FIELD_TO_URL_MAP[key]] << referenced_resource if referenced_resource
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Composition::Section) }
          resource_hash.merge!(parse_sections(value, bundle))
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Reference) }
          resource_hash[FIELD_TO_URL_MAP[key]] ||= []
          value.each do |val| 
            referenced_resource = find_resource_in_bundle(val.reference, bundle)
            unresolved_references << val.reference if !referenced_resource
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
            else
              unresolved_references << ref.reference
            end
          end
        else
          resource_key = CODE_TO_URL_MAP[code]
          hash[resource_key] ||= []
          sec.entry.each do |ref| 
            referenced_resource = find_resource_in_bundle(ref.reference, bundle)
            unresolved_references << ref.reference if !referenced_resource
            hash[resource_key] << referenced_resource if referenced_resource
          end
        end
      end
    end
    
    def multiple_reference_types?(code)
      CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP.keys.include?(code)
    end
    
    
    def profile_from_resource_type(code, resource_type)
      CODE_TO_MULTIPLE_ENTRY_RESOURCE_MAP[code][resource_type]
    end
    
    ## TODO: we may have to be more comprehensive with checks for references - TBD
    def find_resource_in_bundle(reference, bundle)
      bundle.entry.find { |res| res.resource.id == reference.split('/').last && res.resource.resourceType == reference.split('/').first }&.resource
    end
  end
end
