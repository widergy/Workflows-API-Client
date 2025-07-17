require 'spec_helper'

describe WorkflowsApiClient::SurveyHistoriesController, type: :controller do
  let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
  let(:headers) { { 'Utility-Id': utility_id.to_s } }

  describe 'PUT #update' do
    let(:service) do
      put :update, params: { use_route: 'workflows/survey_histories/:id', **params }
    end
    let(:params) { { id: id, values: values }.compact }
    let(:headers) { { 'Utility-Id': utility_id.to_s, 'Content-Type': 'application/json' } }
    let(:values) { [{ score: '5' }, {}].sample }
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
end
