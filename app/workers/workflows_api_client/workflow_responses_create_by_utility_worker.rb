module WorkflowsApiClient
  class WorkflowResponsesCreateByUtilityWorker < BaseWorker
    private

    def user_id
      @user_id ||= params[:body_params][:consumer_user_id]
    end

    def account_id
      @account_id ||= params[:body_params][:consumer_account_id]
    end

    def user
      @user ||= user_id.present? ? User.find(user_id) : nil
    end

    def account
      account_id.present? ? user.accounts.find(account_id) : nil
    end

    def utility_ids
      {
        utility_user_id: user&.external_id,
        utility_account_id: account&.external_id
      }.compact
    end

    def service_params
      {
        http_method: :post,
        url: BASE_URL + WORKFLOW_RESPONSES_SERVICE_URL,
        body_params: params[:body_params].merge(utility_ids)&.to_json
      }
    end
  end
end
