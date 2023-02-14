module WorkflowsApiClient
  class WorkflowsController < ApplicationBaseController
    include AsyncRequestHelper

    def index
      response = async_custom_execute(WorkflowsIndexByUtilityWorker, request_headers)
      async_custom_response(response)
    end

    def show
      response = async_custom_execute(WorkflowsShowByUtilityWorker, show_params)
      async_custom_response(response)
    end

    private

    def show_params
      { uri_params: { code: params.require(:code) } }
    end
  end
end
