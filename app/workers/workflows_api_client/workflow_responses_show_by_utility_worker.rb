module WorkflowsApiClient
  class WorkflowResponsesShowByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :get,
        url: "#{BASE_URL}#{WORKFLOW_RESPONSES_SERVICE_URL}/#{params[:uri_params][:id]}"
      }
    end
  end
end
