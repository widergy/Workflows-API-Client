require 'rails'

module WorkflowsApiClient
  class ApplicationBaseController < ControllerInheritanceHelper.inherit
    def request_headers
      {
        headers: {
          'Utility-Id': utility_id,
          'Content-Type': request.headers['Content-Type']
        }
      }
    end

    def utility_id
      utility_header = request.headers['Utility-Id']
      raise ActionController::ParameterMissing, 'Utility-ID header' if utility_header.blank?

      utility_header.to_s
    end
  end
end
