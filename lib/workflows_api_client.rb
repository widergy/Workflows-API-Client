require 'workflows_api_client/engine.rb'
require 'workflows_api_client/methods.rb'

module WorkflowsApiClient
  @config = {
    workflows_api_url: '',
    consumer_api_key: '',
    consumer_api_secret: '',
    async_request_helper: 'AsyncRequest::ApplicationHelper',
    controller_to_inherit_authentication: 'ApplicationController',
    services_namespace: 'workflows',
    define_routes_manually: false
  }

  def self.configure
    yield self
  end

  def self.workflows_api_url=(workflows_api_url)
    @config[:workflows_api_url] = workflows_api_url
  end

  def self.consumer_api_key=(consumer_api_key)
    @config[:consumer_api_key] = consumer_api_key
  end

  def self.consumer_api_secret=(consumer_api_secret)
    @config[:consumer_api_secret] = consumer_api_secret
  end

  def self.async_request_helper=(async_request_helper)
    @config[:async_request_helper] = async_request_helper
  end

  def self.controller_to_inherit_authentication=(controller_to_inherit_authentication)
    @config[:controller_to_inherit_authentication] = controller_to_inherit_authentication
  end

  def self.services_namespace=(services_namespace)
    @config[:services_namespace] = services_namespace
  end

  def self.define_routes_manually=(define_routes_manually)
    @config[:define_routes_manually] = define_routes_manually
  end

  def self.config
    @config
  end
end
