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
      perform(build_service(formatted_params(params)))
    end

    private

    def perform
      response = WorkflowsApiClient::RequestPerformer.new(service).perform
      [response.code, response.body]
    end

    def formatted_params(params)
      params
    end

    def build_service(service_args)
      {
        http_method: service_args[:http_method],
        body_params: service_args[:body_params],
        headers: service_args[:headers],
        query_params: service_args[:query_params],
        uri_params: service_args[:uri_params],
        url: BASE_URL + service_args[:url]
      }
    end

    def service_params(method, url)
      {
        http_method: method,
        url: url
      }
    end
  end
end
