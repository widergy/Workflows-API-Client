module WorkflowsApiClient
  module ControllerInheritanceHelper
    def self.inherit
      controller_config = WorkflowsApiClient.config[:controller_to_inherit_authentication]
      controller_class = "::#{controller_config}".safe_constantize
      if controller_class.blank?
        message = 'controller_to_inherit_authentication'
        raise WorkflowsApiClient::Exceptions::InvalidConfiguration, message
      end
      controller_class
    end
  end
end
