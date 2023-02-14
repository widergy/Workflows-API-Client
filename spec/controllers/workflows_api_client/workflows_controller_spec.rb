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
  end
end
