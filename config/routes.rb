WorkflowsApiClient::Engine.routes.draw do
  get 'workflows', to: 'workflows#index'
  get 'workflows/:code', to: 'workflows#show'
end
