module WorkflowsApiClient
  module CustomMiddlewaresHelper
    def custom_middleware
      custom_middlewares = WorkflowsApiClient.config[:custom_middlewares]
      return if custom_middlewares.blank?

      custom_middlewares.find do |middleware|
        return false unless middleware&.respond_to?(:should_execute?)
        return false unless middleware&.respond_to?(:execute)
        middleware.should_execute?(params)
      end
    end
  end
end
