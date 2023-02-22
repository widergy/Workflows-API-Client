module WorkflowsApiClient
  class WorkflowResponsesDestroyByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :delete,
        url: "#{BASE_URL}#{WORKFLOW_RESPONSES_SERVICE_URL}/#{params[:uri_params][:id]}"
      }
    end
  end
end
