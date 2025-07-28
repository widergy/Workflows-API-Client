module WorkflowsApiClient
  class SurveysController < ApplicationBaseController
    skip_before_action :authenticate_request,
                       only: WorkflowsApiClient.config[:skip_auth_survey_services]

    include AsyncRequestHelper

    def show
      response = async_custom_execute(SurveysShowByUtilityWorker, show_params)
      async_custom_response(response)
    end

    private

    def show_params
      {
        uri_params: { code: params.require(:code) },
        query_params: current_user_id
      }
    end

    def current_user_id
      { consumer_user_id: current_user&.id }
    end
  end
end
