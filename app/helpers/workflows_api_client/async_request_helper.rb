module WorkflowsApiClient
  module AsyncRequestHelper
    async_request_helper = "::#{WorkflowsApiClient.config[:async_request_helper]}".safe_constantize
    raise Exceptions::InvalidConfiguration, 'async_request_helper' if async_request_helper.blank?
    include async_request_helper

    private

    def async_custom_response(job_id)
      render json: { response: job_id, job_id: job_id, url: async_request_url(job_id) },
             status: :accepted
    end

    def async_request_url(job_id)
      async_request.job_url(job_id)
    end
  end
end
