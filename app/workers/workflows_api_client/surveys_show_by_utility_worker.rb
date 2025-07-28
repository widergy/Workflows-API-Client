module WorkflowsApiClient
  class SurveysShowByUtilityWorker < BaseWorker
    private

    def user_id
      @user_id ||= params[:query_params][:consumer_user_id].to_s
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
        http_method: :get,
        url: "#{BASE_URL}#{SURVEYS_SERVICE_URL}/#{params[:uri_params][:code]}",
        query_params: params[:query_params].merge(utility_ids)
      }
    end
  end
end
