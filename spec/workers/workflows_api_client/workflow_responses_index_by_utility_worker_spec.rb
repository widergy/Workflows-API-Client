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

    context 'with successful response' do
      subject(:execute_worker) do
        VCR.use_cassette 'workflow_responses_index_by_utility_worker/valid_params' do
          worker_instance.execute(params)
        end
      end

      before { worker_instance.params = params }

      it_behaves_like 'successful service build'
      it_behaves_like 'successful worker response'
    end

    context 'when unsuccessful service response' do
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
