require 'spec_helper'

describe WorkflowsApiClient::WorkflowsController, type: :controller do
  describe 'GET #index' do
    context 'when calling the appropriate worker' do
      let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
      let(:headers) do
        { 'Utility-Id': utility_id.to_s, 'Content-Type': nil }
      end

      before do
        request.headers.merge(headers)
        get :index, params: { use_route: 'workflows/workflows' }
      end

      it_behaves_like 'endpoint with polling and recovers headers of the request'
    end

    context 'when Utility-Id header is not present' do
      let(:service) { get :index, params: { use_route: 'workflows/workflows' } }

      it_behaves_like 'validates the presence of the utility id header'
    end
  end

  describe 'GET #show' do
    context 'when calling the appropriate worker' do
      let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
      let(:headers) do
        { 'Utility-Id': utility_id.to_s, 'Content-Type': nil }
      end
      let(:code) { Faker::Number.between(from: 1, to: 5) }

      before do
        request.headers.merge(headers)
        get :show, params: { use_route: 'workflows/workflows/:code', code: code }
      end

      it_behaves_like 'endpoint with polling and recovers headers of the request'
    end

    context 'when Utility-Id header is not present' do
      let(:service) { get :show, params: { use_route: 'workflows/workflows/:code' } }

      it_behaves_like 'validates the presence of the utility id header'
    end

    context 'when code param is not present' do
      let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
      let(:headers) do
        { 'Utility-Id': utility_id.to_s, 'Content-Type': nil }
      end
      let(:code) { nil }
      let(:service) { get :show, params: { use_route: 'workflows/workflows/:code', code: code } }

      before { request.headers.merge(headers) }

      it 'raises ActionController::ParameterMissing exception' do
        expect { service }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
