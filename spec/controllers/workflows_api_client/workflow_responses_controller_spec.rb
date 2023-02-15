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

  describe 'GET #show' do
    let(:id) { 9 }
    let(:service) do
      get :show, params: { use_route: 'workflows/workflow_responses/:id', id: id }
    end

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

    context 'when id param is not present' do
      let(:id) { nil }

      before { request.headers.merge(headers) }

      it 'raises ActionController::ParameterMissing exception' do
        expect { service }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
