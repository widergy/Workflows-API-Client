require 'spec_helper'

describe WorkflowsApiClient::WorkflowResponsesController, type: :controller do
  let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
  let(:headers) { { 'Utility-Id': utility_id.to_s } }

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
      it_behaves_like 'responds with the exception of missing parameters'
    end

    context 'with authentication disabled' do
      it_behaves_like 'authentication disabled service'
    end
  end

  describe 'GET #show' do
    let(:id) { Faker::Number.between(from: 1, to: 10) }
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
      it_behaves_like 'responds with the exception of missing parameters'
    end

    context 'when id param is not present' do
      let(:id) { nil }

      before { request.headers.merge(headers) }

      it 'raises ActionController::ParameterMissing exception' do
        expect { service }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe 'POST #create' do
    let(:service) do
      post :create, params: {
        use_route: 'workflows/workflow_responses', workflow_code: workflow_code,
        input_values: input_values, account_id: consumer_account_id
      }
    end
    let(:headers) { { 'Utility-Id': utility_id.to_s, 'Content-Type': 'application/json' } }
    let(:input_values) { { key: 'value' } }
    let(:workflow_code) { Faker::Number.between(from: 1, to: 10) }
    let(:consumer_account_id) { Faker::Number.between(from: 1, to: 10) }

    context 'when parameters are valid' do
      context 'when calling the appropriate worker' do
        before do
          request.headers.merge(headers)
          service
        end

        it_behaves_like 'endpoint with polling and request headers recovery'
      end
    end

    context 'when parameters are invalid' do
      let(%i[workflow_code input_values].sample) { nil }

      it_behaves_like 'responds with the exception of missing parameters'
    end

    context 'when Utility-Id header is not present' do
      it_behaves_like 'responds with the exception of missing parameters'
    end
  end

  describe 'PUT #update' do
    let(:service) do
      put :update, params: { use_route: 'workflows/workflow_responses/:id', **params }
    end
    let(:params) { { id: id, input_values: input_values }.compact } 
    let(:headers) { { 'Utility-Id': utility_id.to_s, 'Content-Type': 'application/json' } }
    let(:input_values) { [{ key: 'value' }, {}].sample }
    let(:id) { Faker::Number.between(from: 1, to: 10) }

    context 'when parameters are valid' do
      context 'when calling the appropriate worker' do
        before do
          request.headers.merge(headers)
          service
        end

        it_behaves_like 'endpoint with polling and request headers recovery'
      end
    end

    context 'when parameters are invalid' do
      let(%i[id input_values].sample) { nil }

      it_behaves_like 'responds with the exception of missing parameters'
    end

    context 'when Utility-Id header is not present' do
      it_behaves_like 'responds with the exception of missing parameters'
    end
  end

  describe 'DELETE #destroy' do
    let(:id) { 9 }
    let(:service) do
      delete :destroy, params: { use_route: 'workflows/workflow_responses/:id', id: id }
    end
    let(:headers) { { 'Utility-Id': utility_id.to_s, 'Content-Type': 'application/json' } }

    context 'when calling the appropriate worker' do
      before do
        request.headers.merge(headers)
        service
      end

      it_behaves_like 'endpoint with polling and request headers recovery'
    end

    context 'when Utility-Id header is not present' do
      it_behaves_like 'responds with the exception of missing parameters'
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
