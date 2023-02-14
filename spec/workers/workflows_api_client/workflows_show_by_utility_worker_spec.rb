require 'spec_helper'

describe WorkflowsApiClient::WorkflowsShowByUtilityWorker do
  let(:worker_instance) { described_class.new }

  describe '#execute' do
    let(:utility_id) { Faker::Number.between(from: 1, to: 10) }
    let(:code) { 'test_code' }
    let(:uri_params) { { code: code } }
    let(:params) do
      {
        headers: { 'Utility-Id': utility_id.to_s },
        uri_params: uri_params
      }
    end
    let(:base_url) { worker_instance.class::BASE_URL }
    let(:workflows_url) { worker_instance.class::WORKFLOWS_SERVICE_URL }

    let(:expected_service) do
      {
        http_method: :get,
        body_params: nil,
        headers: { "Utility-Id": utility_id.to_s },
        query_params: nil,
        uri_params: uri_params,
        url: "#{base_url}#{workflows_url}/#{code}"
      }.stringify_keys
    end

    context 'with successful response' do
      subject(:execute_worker) do
        VCR.use_cassette 'workflows_show_by_utility_worker/valid_params' do
          worker_instance.execute(params)
        end
      end

      before { worker_instance.params = params }

      it_behaves_like 'successfuly builds service'
      it_behaves_like 'successful worker response'
    end

    context 'when service response is unsuccessful' do
      subject(:execute_worker) do
        worker_instance.execute(params)
      end

      context 'when the service response fails' do
        it_behaves_like 'failed worker response'
      end

      context 'when an error occurs with the service' do
        it_behaves_like 'unhandled error from worker response'
      end
    end
  end
end
