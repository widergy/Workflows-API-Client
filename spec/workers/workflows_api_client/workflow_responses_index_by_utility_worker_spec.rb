require 'spec_helper'

describe WorkflowsApiClient::WorkflowResponsesIndexByUtilityWorker do
  let(:worker_instance) { described_class.new }

  describe '#execute' do
    let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
    let(:query_params) { { user_external_id: 2 } }
    let(:utility_id_header) { { 'Utility-Id': utility_id.to_s } }
    let(:params) { { headers: utility_id_header, query_params: query_params } }
    let(:base_url) { worker_instance.class::BASE_URL }
    let(:workflows_url) { worker_instance.class::WORKFLOW_RESPONSES_SERVICE_URL }
    let(:expected_service) do
      {
        http_method: :get,
        body_params: nil,
        headers: utility_id_header,
        query_params: query_params,
        uri_params: nil,
        url: base_url + workflows_url
      }.stringify_keys
    end

    context 'when the service responds properly' do
      subject(:execute_worker) do
        VCR.use_cassette 'workflow_responses_index_by_utility_worker/valid_params' do
          worker_instance.execute(params)
        end
      end

      before do
        worker_instance.params = params
      end

      it_behaves_like 'builds the service properly'
      it_behaves_like 'the worker response is successful'
    end

    context 'when the service responds with error' do
      subject(:execute_worker) do
        worker_instance.execute(params)
      end

      context 'when the service responds badly' do
        it_behaves_like 'the worker response is failed'
      end

      context 'when an error occurs with the service' do
        it_behaves_like 'the worker response is failed by error'
      end
    end
  end
end
