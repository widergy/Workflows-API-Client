module WorkflowsApiClient
  class WorkflowsController < ApplicationBaseController
    skip_before_action :authenticate_request,
                       only: WorkflowsApiClient.config[:skip_auth_workflows_services]

    include AsyncRequestHelper

    def index
      response = async_custom_execute(WorkflowsIndexByUtilityWorker)
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
