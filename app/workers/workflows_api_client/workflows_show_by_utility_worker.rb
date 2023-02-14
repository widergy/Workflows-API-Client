module WorkflowsApiClient
  class WorkflowsShowByUtilityWorker < BaseWorker
    private

    def service_params
      {
        http_method: :get,
        url: "#{BASE_URL}#{WORKFLOWS_SERVICE_URL}/#{params[:uri_params][:code]}"
      }
    end
  end
end
