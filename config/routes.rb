WorkflowsApiClient::Engine.routes.draw do
  resources :workflows, only: %i[index show], param: :code
  resources :workflow_responses, only: %i[index show create]
end
