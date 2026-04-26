module WorkflowsApiClient
  class ApplicationBaseController < ControllerInheritanceHelper.inherit
    include CustomMiddlewaresHelper
    before_action :execute_custom_middleware

    def async_custom_execute(worker_class, worker_params = {})
      execute_async(worker_class, worker_params.merge(request_headers))
    end

    def request_headers
      {
        headers: {
          'Utility-Id': utility_id,
          'Content-Type': request.headers['Content-Type'],
          'Channel': channel,
          'Client-Number': request.headers['Client-Number']
        }.compact
      }
    end

    def channel
      super if defined?(super)
    end

    def utility_id
      utility_header = request.headers['Utility-Id']
      raise ActionController::ParameterMissing, 'Utility-ID header' if utility_header.blank?

      utility_header.to_s
    end

    def execute_custom_middleware
      return unless WorkflowsApiClient.config[:allow_custom_middlewares]
      return unless custom_middleware.present?
      custom_middleware.execute(params)
    end
  end
end
