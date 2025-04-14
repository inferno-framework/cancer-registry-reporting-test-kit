require_relative 'version'

module CancerRegistryReportingTestKit
  class Metadata < Inferno::TestKit
    id :cancer_registry_reporting_test_kit
    title 'Cancer Registry Reporting Test Kit'
    description <<~DESCRIPTION
      TODO

      <!-- break -->

      TODO
    DESCRIPTION
    suite_ids [:ccrr_ehr, :ccrr_v100_report_generation]
    tags []
    last_updated LAST_UPDATED
    version VERSION
    maturity 'Low'
    authors ['MITRE Inferno Team']
    repo 'https://github.com/inferno-framework/cancer-registry-reporting-test-kit/'
  end
end
