require 'rails/generators/base'

module WorkflowsApiClient
  class Install < Rails::Generators::Base
    source_root File.expand_path('../../templates', __dir__)

    def copy_initializer_file
      config_file = 'workflows_api_client.rb'
      copy_file config_file, "config/initializers/#{config_file}"
    end
  end
end
