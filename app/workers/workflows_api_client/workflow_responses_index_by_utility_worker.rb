module WorkflowsApiClient
  class WorkflowResponsesIndexByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :get,
        url: BASE_URL + WORKFLOW_RESPONSES_SERVICE_URL
      }
    end
  end
end
