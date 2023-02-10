require 'net/http'
require 'open-uri'

module WorkflowsApiClient
  module RequestPerformerHelper
    HTTP_TIMEOUT_ERRORS = [Net::OpenTimeout, Net::ReadTimeout].freeze

    ALL_HTTP_ERRORS = [
      Net::OpenTimeout, Net::ReadTimeout, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
      Net::ProtocolError, OpenURI::HTTPError, Timeout::Error, Errno::ECONNREFUSED,
      Errno::ECONNRESET, Errno::ETIMEDOUT, Errno::EHOSTUNREACH, Errno::EINVAL, EOFError,
      OpenSSL::SSL::SSLError
    ].freeze

    Response = Struct.new(:code, :body, :headers)

    private

    def log_request
      Rails.logger.info do
        "\n\nSending #{http_method} request to URL: #{url} \n" \
        "Headers: #{headers} \n Body: #{body_params} \n" \
        "Query params: #{query_params}\n\n"
      end
    end

    def log_response(response)
      Rails.logger.info do
        "\n\nReceiving response from: \n" \
        "External API NAME: API-Workflows \n" \
        "Service: #{http_method} #{url} \n" \
        "Status Code: #{response&.code} \n" \
        "Content-Type: #{response&.headers&.fetch('content-type', {})} \n" \
        "Body:#{response&.parsed_response}\n" \
      end
    end

    def debug_log_level?
      Rails.application.config.log_level == :debug
    end

    def build_response(status, body, headers = nil)
      self.class::Response.new(status, body, headers)
    end

    def http_timeout_error(e, http_method, url)
      log_error(e, http_method: http_method, url: url)
      build_response(504, { error: 'gateway_timeout' })
    end

    def external_request_error(e, http_method, url)
      log_and_report_error(e, http_method: http_method, url: url)
      build_response(500, { error: 'internal_server_error' })
    end

    def service_unavailable_error(e, http_method, url)
      log_and_report_error(e, http_method: http_method, url: url)
      build_response(501, { error: 'service_unavailable' })
    end

    def internal_server_error(e, http_method, url)
      log_and_report_error(e, http_method: http_method, url: url)
      build_response(500, { error: 'internal_server_error' })
    end

    def log_error(e, http_method: nil, url: nil)
      Rails.logger.error do
        "\n\nError for API Workflows, request: #{http_method} #{url} \n" \
        "#{e.message} \n #{e.backtrace&.join("\n")}\n\n"
      end
    end

    def log_warning(e, http_method: nil, url: nil)
      Rails.logger.warn do
        "\n\nWarning for API Workflows, request: #{http_method} #{url} \n" \
        "#{e.message}\n\n"
      end
    end

    def log_and_report_error(e, http_method: nil, url: nil)
      log_error(e, http_method: http_method, url: url)
      Rollbar.error(e, api: 'API Workflows', url: "#{http_method} #{url}")
    end
  end
end
