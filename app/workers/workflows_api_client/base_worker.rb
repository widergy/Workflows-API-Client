module WorkflowsApiClient
  class BaseWorker
    workflows_api_url = WorkflowsApiClient.config[:workflows_api_url]
    if workflows_api_url.blank?
      raise WorkflowsApiClient::Exceptions::InvalidConfiguration, 'workflows_api_url'
    end

    BASE_URL = workflows_api_url.freeze
    WORKFLOWS_SERVICE_URL = 'workflows'.freeze
    WORKFLOWS_RESPONSE_SERVICE_URL = 'workflow_responses'.freeze

    def execute(params)
      perform(build_service(params))
    end

    private

    def perform(service)
      response = WorkflowsApiClient::RequestPerformer.new(service).perform
      [response.code, response.body]
    end

    def build_service(service_args)
      {
        body_params: service_args[:body_params],
        headers: service_args[:headers],
        query_params: service_args[:query_params],
        uri_params: service_args[:uri_params]
      }.merge(service_params)
    end
  end
end
