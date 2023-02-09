module WorkflowsApiClient
  class RequestPerformer
    include WorkflowsApiClient::RequestPerformerHelper

    def initialize(service)
      @http_method = service[:http_method]
      @body_params = service[:body_params]
      @headers = service[:headers]
      @query_params = service[:query_params]
      @uri_params = service[:uri_params]
      @url = service[:url]
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def perform
      log_request
      @response = HTTParty.send(
        http_method, url, query: query_params, body: body_params, headers: formatted_headers
      )
      process_response
    rescue *HTTP_TIMEOUT_ERRORS => e
      http_timeout_error(e, http_method, url)
    rescue *ALL_HTTP_ERRORS => e
      log_warning(e, http_method: http_method, url: url)
      external_request_error(e, http_method, url)
    rescue ArgumentError => e
      service_unavailable_error(e, http_method, url)
    rescue StandardError => e
      internal_server_error(e, http_method, url)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    private

    attr_reader :response, :http_method, :body_params, :uri_params, :query_params, :headers,
                :url

    def formatted_headers
      authentication = WorkflowsApiClient::RequestAuthenticator.new.perform
      auth_headers = { key: authentication.key, digest: authentication.digest }
      headers.merge(auth_headers)
    end

    def process_response
      log_response(response) if debug_log_level?
      build_response(response.code, response.parsed_response || {}, response.headers)
    end
  end
end
