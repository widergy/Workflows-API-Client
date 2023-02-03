module WorkflowsApiClient
  module Exceptions
    class InvalidConfiguration < StandardError
      def initialize(required_configuration)
        super("The #{required_configuration} configuration is not defined or is invalid")
      end
    end
  end
end
