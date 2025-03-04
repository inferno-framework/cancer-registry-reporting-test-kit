# frozen_string_literal: true

require_relative '../../../../must_support_test'
require_relative '../../../../generator/group_metadata'

module CancerRegistryReportingTestKit
  module HDEAV100
    class PlanDefinitionMustSupportTest < Inferno::Test
      include CancerRegistryReportingTestKit::MustSupportTest

      title 'All must support elements are provided in the Plan Definition resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the PlanDefinition resources
        found previously for the following must support elements:

        * PlanDefinition.PlanDefinition
        * PlanDefinition.action
        * PlanDefinition.action.action
        * PlanDefinition.action.code
        * PlanDefinition.action.condition
        * PlanDefinition.action.condition.expression
        * PlanDefinition.action.condition.expression.language
        * PlanDefinition.action.condition.kind
        * PlanDefinition.action.description
        * PlanDefinition.action.extension:trustServiceEndpoint
        * PlanDefinition.action.input
        * PlanDefinition.action.input.extension:defaultQuery
        * PlanDefinition.action.input.extension:relatedDataId
        * PlanDefinition.action.input.type
        * PlanDefinition.action.output
        * PlanDefinition.action.output.profile
        * PlanDefinition.action.output.type
        * PlanDefinition.action.relatedAction
        * PlanDefinition.action.relatedAction.actionId
        * PlanDefinition.action.relatedAction.offset[x]:offsetDuration
        * PlanDefinition.action.relatedAction.relationship
        * PlanDefinition.action.timing[x]
        * PlanDefinition.action.trigger
        * PlanDefinition.action.trigger.extension:namedEventType
        * PlanDefinition.action.trigger.type
        * PlanDefinition.action:checkReportable
        * PlanDefinition.action:checkReportable.action
        * PlanDefinition.action:checkReportable.action:isEncounterReportable.condition.expression
        * PlanDefinition.action:checkReportable.action:isEncounterReportable.id
        * PlanDefinition.action:checkReportable.action:isEncounterReportable.input
        * PlanDefinition.action:checkReportable.action:isEncounterReportable.input.id
        * PlanDefinition.action:checkReportable.action:shouldContinueReporting.condition.expression
        * PlanDefinition.action:checkReportable.action:shouldContinueReporting.id
        * PlanDefinition.action:checkReportable.code
        * PlanDefinition.action:checkReportable.condition
        * PlanDefinition.action:checkReportable.condition.expression
        * PlanDefinition.action:checkReportable.condition.expression.language
        * PlanDefinition.action:checkReportable.condition.kind
        * PlanDefinition.action:checkReportable.description
        * PlanDefinition.action:checkReportable.extension:trustServiceEndpoint
        * PlanDefinition.action:checkReportable.id
        * PlanDefinition.action:checkReportable.input
        * PlanDefinition.action:checkReportable.input.extension:defaultQuery
        * PlanDefinition.action:checkReportable.input.extension:relatedDataId
        * PlanDefinition.action:checkReportable.input.type
        * PlanDefinition.action:checkReportable.output
        * PlanDefinition.action:checkReportable.output.profile
        * PlanDefinition.action:checkReportable.output.type
        * PlanDefinition.action:checkReportable.relatedAction
        * PlanDefinition.action:checkReportable.relatedAction.actionId
        * PlanDefinition.action:checkReportable.relatedAction.offset[x]:offsetDuration
        * PlanDefinition.action:checkReportable.relatedAction.relationship
        * PlanDefinition.action:checkReportable.timing[x]
        * PlanDefinition.action:checkReportable.trigger
        * PlanDefinition.action:checkReportable.trigger.extension:namedEventType
        * PlanDefinition.action:checkReportable.trigger.type
        * PlanDefinition.action:encounterClose
        * PlanDefinition.action:encounterClose.action
        * PlanDefinition.action:encounterClose.code
        * PlanDefinition.action:encounterClose.condition
        * PlanDefinition.action:encounterClose.condition.expression
        * PlanDefinition.action:encounterClose.condition.expression.language
        * PlanDefinition.action:encounterClose.condition.kind
        * PlanDefinition.action:encounterClose.description
        * PlanDefinition.action:encounterClose.extension:trustServiceEndpoint
        * PlanDefinition.action:encounterClose.id
        * PlanDefinition.action:encounterClose.input
        * PlanDefinition.action:encounterClose.input.extension:defaultQuery
        * PlanDefinition.action:encounterClose.input.extension:relatedDataId
        * PlanDefinition.action:encounterClose.input.type
        * PlanDefinition.action:encounterClose.output
        * PlanDefinition.action:encounterClose.output.profile
        * PlanDefinition.action:encounterClose.output.type
        * PlanDefinition.action:encounterClose.relatedAction
        * PlanDefinition.action:encounterClose.relatedAction.actionId
        * PlanDefinition.action:encounterClose.relatedAction.offset[x]:offsetDuration
        * PlanDefinition.action:encounterClose.relatedAction.relationship
        * PlanDefinition.action:encounterClose.textEquivalent
        * PlanDefinition.action:encounterClose.timing[x]
        * PlanDefinition.action:encounterClose.trigger
        * PlanDefinition.action:encounterClose.trigger.extension:namedEventType
        * PlanDefinition.action:encounterClose.trigger.type
        * PlanDefinition.action:reportCancerData
        * PlanDefinition.action:reportCancerData.action
        * PlanDefinition.action:reportCancerData.action:createCancerReport.id
        * PlanDefinition.action:reportCancerData.action:routeAndSendCancerReport.description
        * PlanDefinition.action:reportCancerData.action:routeAndSendCancerReport.id
        * PlanDefinition.action:reportCancerData.action:routeAndSendCancerReport.textEquivalent
        * PlanDefinition.action:reportCancerData.action:validateCancerReport.id
        * PlanDefinition.action:reportCancerData.code
        * PlanDefinition.action:reportCancerData.condition
        * PlanDefinition.action:reportCancerData.condition.expression
        * PlanDefinition.action:reportCancerData.condition.expression.language
        * PlanDefinition.action:reportCancerData.condition.kind
        * PlanDefinition.action:reportCancerData.description
        * PlanDefinition.action:reportCancerData.extension:trustServiceEndpoint
        * PlanDefinition.action:reportCancerData.id
        * PlanDefinition.action:reportCancerData.input
        * PlanDefinition.action:reportCancerData.input.extension:defaultQuery
        * PlanDefinition.action:reportCancerData.input.extension:relatedDataId
        * PlanDefinition.action:reportCancerData.input.type
        * PlanDefinition.action:reportCancerData.output
        * PlanDefinition.action:reportCancerData.output.profile
        * PlanDefinition.action:reportCancerData.output.type
        * PlanDefinition.action:reportCancerData.relatedAction
        * PlanDefinition.action:reportCancerData.relatedAction.actionId
        * PlanDefinition.action:reportCancerData.relatedAction.offset[x]:offsetDuration
        * PlanDefinition.action:reportCancerData.relatedAction.relationship
        * PlanDefinition.action:reportCancerData.timing[x]
        * PlanDefinition.action:reportCancerData.trigger
        * PlanDefinition.action:reportCancerData.trigger.extension:namedEventType
        * PlanDefinition.action:reportCancerData.trigger.type
        * PlanDefinition.contact
        * PlanDefinition.date
        * PlanDefinition.effectivePeriod
        * PlanDefinition.extension:asyncIndicator
        * PlanDefinition.extension:contentEncrypted
        * PlanDefinition.extension:contentEncryptionAlgorithm
        * PlanDefinition.extension:expectedResponseDuration
        * PlanDefinition.extension:jwksForContentEncryption
        * PlanDefinition.extension:receiverEndpoint
        * PlanDefinition.identifier
        * PlanDefinition.jurisdiction
        * PlanDefinition.library
        * PlanDefinition.publisher
        * PlanDefinition.subject[x]
        * PlanDefinition.title
        * PlanDefinition.type.coding.code
        * PlanDefinition.useContext
      )

      id :ccrr_v100_plan_definition_must_support_test

      def resource_type
        'PlanDefinition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:plan_definition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
