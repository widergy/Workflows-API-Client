require 'spec_helper'

describe WorkflowsApiClient::WorkflowResponsesController, type: :controller do
  let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
  let(:headers) do
    { 'Utility-Id': utility_id.to_s }
  end

  describe 'GET #index' do
    let(:service) { get :index, params: { use_route: 'workflows/workflow_responses' } }

    context 'when calling the appropriate worker' do
      before do
        request.headers.merge(headers)
        service
      end

      it_behaves_like 'endpoint with polling and request headers recovery'
    end

    context 'when Utility-Id header is not present' do
      it_behaves_like 'utility id header validation'
    end
  end
end
