WorkflowsApiClient::Engine.routes.draw do
  get 'workflows', to: 'workflows#index'
  get 'workflows/:code', to: 'workflows#show'

  get 'workflow_responses', to: 'workflow_responses#index'
end
