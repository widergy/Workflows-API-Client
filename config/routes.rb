WorkflowsApiClient::Engine.routes.draw do
  get 'workflows', to: 'workflows#index'
end
