require 'rails'

module WorkflowsApiClient
  class Engine < ::Rails::Engine
    isolate_namespace WorkflowsApiClient

    initializer 'workflows_api_client', before: :load_config_initializers do
      unless WorkflowsApiClient.config[:define_routes_manually]
        namespace = WorkflowsApiClient.config[:services_namespace]
        Rails.application.routes.append do
          mount WorkflowsApiClient::Engine, at: "/#{namespace}", as: 'workflows_api_client'
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
