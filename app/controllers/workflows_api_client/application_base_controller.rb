module WorkflowsApiClient
  class ApplicationBaseController < ControllerInheritanceHelper.inherit
    def request_headers
      {
        headers: {
          'Utility-ID': request.headers['Utility-ID'].to_s,
          'Content-Type': request.headers['Content-Type']
        }
      }
    end
  end
end
