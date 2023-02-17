module WorkflowsApiClient
  class WorkflowResponsesController < ApplicationBaseController
    include AsyncRequestHelper

    def index
      response = async_custom_execute(WorkflowResponsesIndexByUtilityWorker, index_params)
      async_custom_response(response)
    end

    def show
      response = async_custom_execute(WorkflowResponsesShowByUtilityWorker, show_params)
      async_custom_response(response)
    end

    def create
      response = async_custom_execute(WorkflowResponsesCreateByUtilityWorker, create_params)
      async_custom_response(response)
    end

    def update
      response = async_custom_execute(WorkflowResponsesUpdateByUtilityWorker, update_params)
      async_custom_response(response)
    end

    private

    def index_params
      { query_params: permitted_index_params }
    end

    def show_params
      { uri_params: { id: params.require(:id) } }
    end

    def create_params
      { body_params: permitted_create_params.to_h }
    end

    def update_params
      update_params_hash = permitted_update_params.to_h
      { body_params: { input_values: update_params_hash[:input_values] },
        uri_params: { id: update_params_hash[:id] } }
    end

    def permitted_index_params
      params.permit(%i[user_external_id account_external_id]).to_h
    end

    def permitted_create_params
      params.require(%i[workflow_code input_values])
      params.permit(:workflow_code, input_values: {})
    end

    def permitted_update_params
      params.require(%i[id input_values])
      params.permit(:id, input_values: {})
    end
  end
end
