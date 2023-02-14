module WorkflowsApiClient
  class WorkflowResponsesController < ApplicationBaseController
    include AsyncRequestHelper

    def index
      response = async_custom_execute(WorkflowResponsesIndexByUtilityWorker, index_params)
      async_custom_response(response)
    end

    private

    def index_params
      { query_params: permitted_index_params }
    end

    def permitted_index_params
      params.permit(:user_external_id, :account_external_id).to_h
    end
  end
end
