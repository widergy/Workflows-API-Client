require 'workflows_api_client/methods_helper.rb'

module WorkflowsApiClient
  def self.workflows_index(utility_id)
    WorkflowsIndexByUtilityWorker.new.execute(request_headers(utility_id))
  end

  def self.workflows_show(utility_id, code)
    WorkflowsShowByUtilityWorker.new.execute(show_params(utility_id, code))
  end

  def self.workflow_responses_index(utility_id, filters = nil)
    WorkflowResponsesIndexByUtilityWorker.new.execute(index_response_params(utility_id, filters))
  end

  def self.workflow_responses_show(utility_id, id)
    WorkflowResponsesShowByUtilityWorker.new.execute(show_params(utility_id, { id: id }))
  end

  def self.workflow_responses_create(utility_id, workflow_code, input_values, *external_params)
    WorkflowResponsesCreateByUtilityWorker.new.execute(
      create_params(utility_id, workflow_code, input_values, external_params)
    )
  end

  def self.workflow_responses_update(utility_id, workflow_response_id, input_values)
    WorkflowResponsesUpdateByUtilityWorker.new.execute(
      update_params(utility_id, workflow_response_id, input_values)
    )
  end
end
