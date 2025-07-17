WorkflowsApiClient::Engine.routes.draw do
  resources :workflows, only: %i[index show], param: :code
  resources :workflow_responses, only: %i[index show create update destroy]
  resources :surveys, only: %i[show], param: :code
  resources :survey_histories, only: %i[update]
end
