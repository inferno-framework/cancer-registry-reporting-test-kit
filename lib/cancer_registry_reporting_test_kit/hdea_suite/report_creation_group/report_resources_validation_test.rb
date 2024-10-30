

module CancerRegistryReportingTestKit
  class HDEAReportResourcesValidationTest < Inferno::Test
    title 'HDEA Report Resources Validation Tests'
    id :ccrr_hdea_report_resources_validation_test

    description %(
        This is a placeholder for a set of tests to validate resources marked as 
        MS references within a report composition. The bundle will contain the resources as entries.
        The test first checks that (1) references to the entries in the composition resolve 
        and then (2) that each referred to resource is profile conformant.
      )

      # will have to go through all the entries in the content bundle
      # and validate each against the appropriate profile.
      # ensuring it is the appropriate profile will depend on their reference in the composition
      # for example, smoking status is an entry within a slice that has
      # code.code == 29762-2, indicating that whatever resource it references should 
      # be conformant to US Core Smoking Status Observation

  end
end
