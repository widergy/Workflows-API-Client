module WorkflowsApiClient
  class BaseWorker
    attr_accessor :params

    def initialize
      workflows_api_url = WorkflowsApiClient.config[:workflows_api_url]
      return if workflows_api_url.present?

      raise WorkflowsApiClient::Exceptions::InvalidConfiguration, 'workflows_api_url'
    end

    BASE_URL = WorkflowsApiClient.config[:workflows_api_url].freeze
    WORKFLOWS_SERVICE_URL = 'workflows'.freeze
    WORKFLOW_RESPONSES_SERVICE_URL = 'workflow_responses'.freeze

    def execute(params)
      @params = params
      perform
    rescue StandardError => e
      error_response(e)
    end

    private

    def perform
      response = WorkflowsApiClient::RequestPerformer.new(build_service).perform
      [response.code, response.body]
    end

    def build_service
      {
        body_params: params[:body_params]&.to_json,
        headers: params[:headers],
        query_params: params[:query_params],
        uri_params: params[:uri_params]
      }.merge(service_params)
    end

    def error_response(error)
      ErrorResponseBuilder.new(:unprocessable_entity).add_error(:workflows_api_client_error, message: error.message).to_a
    end
  end
end
