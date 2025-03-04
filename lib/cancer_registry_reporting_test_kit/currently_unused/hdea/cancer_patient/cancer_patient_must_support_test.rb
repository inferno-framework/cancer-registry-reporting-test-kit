# frozen_string_literal: true

require_relative '../../../must_support_test'
require_relative '../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class CancerPatientMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Cancer Patient resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.address.city
        * Patient.address.district
        * Patient.address.extension:dataAbsentReason
        * Patient.address.extension:dataAbsentReason.value[x]
        * Patient.address.line
        * Patient.address.period
        * Patient.address.postalCode
        * Patient.address.state
        * Patient.address.state.extension:data-absent-reason
        * Patient.birthDate
        * Patient.birthDate.extension:dataAbsentReason
        * Patient.birthDate.extension:dataAbsentReason.value[x]
        * Patient.communication
        * Patient.communication.language
        * Patient.communication.language.extension:dataAbsentReason
        * Patient.communication.language.extension:dataAbsentReason.value[x]
        * Patient.contact
        * Patient.contact.address
        * Patient.contact.address.extension:dataAbsentReason
        * Patient.contact.address.extension:dataAbsentReason.value[x]
        * Patient.contact.name
        * Patient.contact.name.extension:dataAbsentReason
        * Patient.contact.name.extension:dataAbsentReason.value[x]
        * Patient.contact.relationship
        * Patient.contact.telecom
        * Patient.contact.telecom.extension:dataAbsentReason
        * Patient.contact.telecom.extension:dataAbsentReason.value[x]
        * Patient.extension:birthPlace
        * Patient.extension:birthsex
        * Patient.extension:ethnicity
        * Patient.extension:genderIdentity
        * Patient.extension:race
        * Patient.extension:tribalAffiliation
        * Patient.gender
        * Patient.gender.extension:dataAbsentReason
        * Patient.gender.extension:dataAbsentReason.value[x]
        * Patient.generalPractitioner
        * Patient.identifier
        * Patient.identifier.extension:dataAbsentReason.value[x]
        * Patient.identifier.system
        * Patient.identifier.value
        * Patient.identifier:MR
        * Patient.identifier:MR.extension:dataAbsentReason.value[x]
        * Patient.identifier:MR.system
        * Patient.identifier:MR.type
        * Patient.identifier:MR.type.coding
        * Patient.identifier:MR.type.coding.code
        * Patient.identifier:MR.type.coding.system
        * Patient.identifier:MR.value
        * Patient.identifier:MedicaidIdentifier
        * Patient.identifier:MedicaidIdentifier.extension:dataAbsentReason.value[x]
        * Patient.identifier:MedicaidIdentifier.system
        * Patient.identifier:MedicaidIdentifier.type
        * Patient.identifier:MedicaidIdentifier.type.coding
        * Patient.identifier:MedicaidIdentifier.type.coding.code
        * Patient.identifier:MedicaidIdentifier.type.coding.system
        * Patient.identifier:MedicaidIdentifier.value
        * Patient.identifier:MedicareIdentifier
        * Patient.identifier:MedicareIdentifier.extension:dataAbsentReason.value[x]
        * Patient.identifier:MedicareIdentifier.system
        * Patient.identifier:MedicareIdentifier.type
        * Patient.identifier:MedicareIdentifier.type.coding
        * Patient.identifier:MedicareIdentifier.type.coding.code
        * Patient.identifier:MedicareIdentifier.type.coding.system
        * Patient.identifier:MedicareIdentifier.value
        * Patient.identifier:SSNIdentifier
        * Patient.identifier:SSNIdentifier.extension:dataAbsentReason.value[x]
        * Patient.identifier:SSNIdentifier.system
        * Patient.identifier:SSNIdentifier.type
        * Patient.identifier:SSNIdentifier.type.coding
        * Patient.identifier:SSNIdentifier.type.coding.code
        * Patient.identifier:SSNIdentifier.type.coding.system
        * Patient.identifier:SSNIdentifier.value
        * Patient.managingOrganization
        * Patient.maritalStatus
        * Patient.name
        * Patient.name.extension:dataAbsentReason
        * Patient.name.extension:dataAbsentReason.value[x]
        * Patient.name.family
        * Patient.name.family.extension:data-absent-reason
        * Patient.name.given
        * Patient.name.given.extension:data-absent-reason
        * Patient.telecom
        * Patient.telecom.extension:dataAbsentReason
        * Patient.telecom.extension:dataAbsentReason.value[x]
        * Patient.telecom.system
        * Patient.telecom.use
        * Patient.telecom.value
        * Patient.telecom:email
        * Patient.telecom:email.system
        * Patient.telecom:email.use
        * Patient.telecom:email.value
        * Patient.telecom:phone
        * Patient.telecom:phone.system
        * Patient.telecom:phone.use
        * Patient.telecom:phone.value
      )

      id :ccrr_v100_cancer_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:cancer_patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
