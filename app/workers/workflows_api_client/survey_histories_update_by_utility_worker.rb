module WorkflowsApiClient
  class SurveyHistoriesUpdateByUtilityWorker < BaseWorker
    private

    def user_id
      @user_id ||= params[:body_params][:consumer_user_id]
    end

    def user
      @user ||= user_id.present? ? User.find(user_id) : nil
    end

    def utility_ids
      {
        utility_user_id: user&.external_id
      }.compact
    end

    def service_params
      {
        http_method: :put,
        url: "#{BASE_URL}#{SURVEY_HISTORIES_SERVICE_URL}/#{params[:uri_params][:id]}",
        body_params: params[:body_params].merge(utility_ids)&.to_json
      }
    end
  end
end
