module WorkflowsApiClient
  class WorkflowResponsesCreateByUtilityWorker < BaseWorker
    private

    def account_id
      @account_id ||= params[:body_params].extract!(:account_id)[:account_id]
    end

    def account
      account_id.present? ? Account.find(account_id) : nil
    end

    def account_ids
      {
        consumer_account_id: account&.id,
        utility_account_id: account&.external_id
      }.compact
    end

    def service_params
      {
        http_method: :post,
        url: BASE_URL + WORKFLOW_RESPONSES_SERVICE_URL,
        body_params: params[:body_params].merge(account_ids)&.to_json
      }
    end
  end
end
