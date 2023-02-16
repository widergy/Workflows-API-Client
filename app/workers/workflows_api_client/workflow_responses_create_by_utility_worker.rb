module WorkflowsApiClient
  class WorkflowResponsesCreateByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :post,
        url: BASE_URL + WORKFLOW_RESPONSES_SERVICE_URL
      }
    end
  end
end
