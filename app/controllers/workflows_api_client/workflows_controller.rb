module WorkflowsApiClient
  class WorkflowsController < ApplicationBaseController
    include AsyncRequestHelper

    def index
      response = execute_async(WorkflowsIndexByUtilityWorker, request_headers)
      async_custom_response(response)
    end
  end
end
