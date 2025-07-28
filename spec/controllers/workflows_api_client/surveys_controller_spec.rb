require 'spec_helper'

describe WorkflowsApiClient::SurveysController, type: :controller do
  let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
  let(:headers) { { 'Utility-Id': utility_id.to_s } }

  describe 'GET #show' do
    let(:code) { Faker::Number.between(from: 1, to: 10) }
    let(:service) do
      get :show, params: { use_route: 'workflows/surveys/:code', code: code }
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

    context 'when code param is not present' do
      let(:code) { nil }

      before { request.headers.merge(headers) }

      it 'raises ActionController::ParameterMissing exception' do
        expect { service }.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
