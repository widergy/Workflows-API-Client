require 'spec_helper'

describe WorkflowsApiClient::WorkflowResponsesUpdateByUtilityWorker do
  let(:worker_instance) { described_class.new }

  describe '#execute' do
    let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
    let(:body_params) { { input_values: { key: 'value' } } }
    let(:id) { 1 }
    let(:uri_params) { { id: id } }
    let(:headers) { { 'Utility-Id': utility_id.to_s, 'Content-Type': 'application/json' } }
    let(:params) { { headers: headers, body_params: body_params, uri_params: uri_params } }
    let(:base_url) { worker_instance.class::BASE_URL }
    let(:workflows_url) { worker_instance.class::WORKFLOW_RESPONSES_SERVICE_URL }
    let(:expected_service) do
      {
        http_method: :put,
        body_params: body_params.to_json,
        headers: headers,
        query_params: nil,
        uri_params: uri_params,
        url: base_url + workflows_url + "/#{id}"
      }.stringify_keys
    end

    context 'with successful response' do
      subject(:execute_worker) do
        VCR.use_cassette 'workflow_responses_update_by_utility_worker/valid_params' do
          worker_instance.execute(params)
        end
      end

      before { worker_instance.params = params }

      it_behaves_like 'successfuly builds service'
      it_behaves_like 'successful worker response'
    end

    context 'when service response is unsuccessful' do
      subject(:execute_worker) { worker_instance.execute(params) }

      context 'when the service response fails' do
        it_behaves_like 'failed worker response'
      end

      context 'when an error occurs with the service' do
        it_behaves_like 'unhandled error from worker response'
      end
    end
  end
end
