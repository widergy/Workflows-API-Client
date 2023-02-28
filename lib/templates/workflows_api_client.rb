WorkflowsApiClient.configure do |config|
  # config.workflows_api_url It is required and should be the API Workflows url depending on the
  # environment you wish to configure. If it is not present an error will be thrown.
  config.workflows_api_url = ''

  # config.consumer_api_key It is required and must be the api_key of the 'Consumer' created in API
  # Workflows according to the environment you want to configure. If it is not present an error
  # will be thrown.
  config.consumer_api_key = ''

  # config.consumer_api_secret It is required and must be the 'api_secret' of the 'Consumer'
  # created in API Workflows according to the environment you want to configure. If it is not
  # present an error will be thrown.
  config.consumer_api_secret = ''

  # config.async_request_helper Required, shall be the helper class that is included in
  # the controllers to make asynchronous calls to API Workflows 'AsyncRequest::ApplicationHelper'
  config.async_request_helper = 'AsyncRequest::ApplicationHelper'

  # config.controller_to_inherit_authentication  Is optional, it shall be the class of the
  # controller that has the desired authentication method for the services generated by the
  # gem. By default it will be the 'ApplicationController' of the gem.
  config.controller_to_inherit_authentication = 'ApplicationController'

  # config.skip_auth_workflows_services Is optional, These are the workflow services
  # that we do not want to authenticate and the possible values to include in the Array are:
  # %i[index show]
  config.skip_auth_workflows_services = %i[]

  # config.skip_auth_workflow_response_services Is optional, These are the workflow response
  # services that we do not want to authenticate and the possible values
  # to include in the Array are:
  # %i[index show create update destroy]
  config.skip_auth_workflow_response_services = %i[]

  # config.services_namespace This is optional, it defaults to 'workflows' and defines the prefix
  # of the paths that the gem will generate. For example the default path will be set to
  # '/workflows/test'. It can be null and have no prefix '/test'.
  config.services_namespace = 'workflows'

  # config.define_routes_manually Is required, defaults to false and defines whether routes will
  # be placed manually or by default by the gem. If manual placement is desired (true), it will be
  # necessary to mount the gem engine under the desired namespace to generate the routes.
  # Including the following statement in the routes.rb file should be sufficient:
  # rubocop:disable Layout/LineLength
  # mount WorkflowsApiClient::Engine, at: "/#{WorkflowsApiClient.config[:services_namespace]}", as: 'workflows_api_client'.
  # rubocop:enable Layout/LineLength
  config.define_routes_manually = false
end
