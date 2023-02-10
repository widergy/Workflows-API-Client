module AsyncRequest
  module ApplicationHelper
    JOB_ID = '5b70a39d-e6f3-4547-bd0f-fe6f9d1fa6af'.freeze

    def execute_async(_worker, _params)
      JOB_ID
    end

    def async_request
      AsyncRequest.new
    end

    class AsyncRequest
      def job_url(job_id)
        "http://localhost:3000/async_request/jobs/#{job_id}"
      end
    end
  end
end
