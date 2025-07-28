module WorkflowsApiClient
  class SurveyHistoriesController < ApplicationBaseController
    skip_before_action :authenticate_request,
                       only: WorkflowsApiClient.config[:skip_auth_survey_history_services]

    include AsyncRequestHelper

    def update
      response = async_custom_execute(SurveyHistoriesUpdateByUtilityWorker, update_params)
      async_custom_response(response)
    end

    private

    def update_params
      update_params_hash = permitted_update_params.to_h
      {
        body_params: { values: update_params_hash[:values] }.merge(current_user_id),
        uri_params: { id: update_params_hash[:id] }
      }
    end

    def permitted_update_params
      params.require(:id)
      missing_values unless params.include?(:values)
      params.permit(:id, values: {})
    end

    def current_user_id
      { consumer_user_id: current_user&.id.to_s }
    end

    def missing_values
      raise ActionController::ParameterMissing, 'values'
    end
  end
end
