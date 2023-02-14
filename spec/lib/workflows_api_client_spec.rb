require 'spec_helper'

describe WorkflowsApiClient do
  let(:utility_id) { 123 }
  let(:expected_headers) do
    {
      headers: {
        'Utility-ID': utility_id.to_s,
        'Content-Type': 'application/json'
      }
    }
  end

  describe '.request_headers' do
    let(:headers) { described_class.request_headers(utility_id) }

    it 'returns the expected request headers' do
      expect(headers).to eq(expected_headers)
    end
  end

  describe '.workflows_index' do
    let(:worker_class) { WorkflowsApiClient::WorkflowsIndexByUtilityWorker }
    let(:method) { :workflows_index }
    let(:args) { [utility_id] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.workflows_show' do
    let(:code) { { test_code: 'code' } }
    let(:worker_class) { WorkflowsApiClient::WorkflowsShowByUtilityWorker }
    let(:method) { :workflows_show }
    let(:args) { [utility_id, code] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.show_params' do
    let(:show_params) { { test: 123 } }
    let(:service_params) { described_class.show_params(utility_id, show_params) }
    let(:expected_params) { { uri_params: show_params }.merge(expected_headers) }

    it_behaves_like 'returns the expected service response params'
  end

  describe '.workflow_responses_index' do
    let(:filter) { { some_filter: 'some_filter' } }
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesIndexByUtilityWorker }
    let(:method) { :workflow_responses_index }
    let(:args) { [utility_id, filter] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.index_response_params' do
    let(:filter) { { some_filter: 'some_filter' } }
    let(:service_params) { described_class.index_response_params(utility_id, filter) }
    let(:expected_params) { { query_params: filter }.merge(expected_headers) }

    it_behaves_like 'returns the expected service response params'
  end

  describe '.workflow_responses_show' do
    let(:id) { Faker::Number.between(from: 1, to: 5) }
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesShowByUtilityWorker }
    let(:method) { :workflow_responses_show }
    let(:args) { [utility_id, id] }

    it_behaves_like 'successful instancing of worker'
  end
end
