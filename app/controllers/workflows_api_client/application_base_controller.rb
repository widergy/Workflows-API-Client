module WorkflowsApiClient
  class ApplicationBaseController < ControllerInheritanceHelper.inherit
    def async_custom_execute(worker_class, worker_params = {})
      execute_async(worker_class, worker_params.merge(request_headers))
    end

    def request_headers
      {
        headers: {
          'Utility-Id': utility_id,
          'Content-Type': request.headers['Content-Type'],
          'Channel': channel
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
  end
end
