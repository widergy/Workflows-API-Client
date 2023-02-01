module WorkflowsApiClient
  class DummyWorker
    include Sidekiq::Worker

    def execute
      [200, { message: 'TEST' }]
    end
  end
end
