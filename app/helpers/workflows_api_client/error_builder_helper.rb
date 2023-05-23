module WorkflowsApiClient
  module ErrorBuilderHelper
    error_builder = "::#{WorkflowsApiClient.config[:error_builder]}".safe_constantize
    raise Exceptions::InvalidConfiguration, 'error_builder' if error_builder.blank?
    include error_builder
  end
end
