require 'workflows_api_client/methods_helper.rb'

module WorkflowsApiClient
  def self.workflows_index(utility_id)
    WorkflowsIndexByUtilityWorker.new.execute(request_headers(utility_id))
  end

  def self.workflows_show(utility_id, code)
    WorkflowsShowByUtilityWorker.new.execute(show_params(utility_id, code))
  end
end
