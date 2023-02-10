module WorkflowsApiClient
  class WorkflowsIndexByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :get,
        url: BASE_URL + WORKFLOWS_SERVICE_URL
      }
    end
  end
end
