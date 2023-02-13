module WorkflowsApiClient
  class ApplicationBaseController < ControllerInheritanceHelper.inherit
    def request_headers
      {
        headers: {
          'Utility-Id': request.headers['Utility-Id'].to_s,
          'Content-Type': request.headers['Content-Type']
        }
      }
    end
  end
end
