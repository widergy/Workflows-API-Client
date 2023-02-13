module WorkflowsApiClient
  class WorkflowsController < ApplicationBaseController
    include AsyncRequestHelper

    def index
      response = execute_async(WorkflowsIndexByUtilityWorker, request_headers)
      async_custom_response(response)
    end

    def show
      response = execute_async(WorkflowsShowByUtilityWorker, show_params)
      async_custom_response(response)
    end

    private

    def show_params
      { uri_params: { code: params.require(:code) } }.merge(request_headers)
    end
  end
end
