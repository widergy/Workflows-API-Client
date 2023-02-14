require 'spec_helper'

describe WorkflowsApiClient::WorkflowsIndexByUtilityWorker do
  let(:worker_instance) { described_class.new }

  describe '#execute' do
    let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
    let(:params) do
      { headers: { 'Utility-Id': utility_id.to_s } }
    end
    let(:expected_service) do
      {
        http_method: :get,
        body_params: nil,
        headers: { "Utility-Id": utility_id.to_s },
        query_params: nil,
        uri_params: nil,
        url: "#{worker_instance.class::BASE_URL}#{worker_instance.class::WORKFLOWS_SERVICE_URL}"
      }.stringify_keys
    end

    context 'when the service responds properly' do
      subject(:execute_worker) do
        VCR.use_cassette 'workflows_index_by_utility_worker/valid_params' do
          worker_instance.execute(params)
        end
      end

      before { worker_instance.params = params }

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
