module WorkflowsApiClient
  module ErrorBuilderHelper
    def self.inherit
      error_builder = "::#{WorkflowsApiClient.config[:error_builder]}".safe_constantize
      raise Exceptions::InvalidConfiguration, 'error_builder' if error_builder.blank?
      error_builder
    end
  end
end
