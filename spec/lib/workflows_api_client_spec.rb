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

  describe '.uri_params' do
    let(:uri_params) { { test: 123 } }
    let(:service_params) { described_class.uri_params(utility_id, uri_params) }
    let(:expected_params) { { uri_params: uri_params }.merge(expected_headers) }

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

  describe '.workflow_responses_create' do
    let(:workflow_code) { Faker::Number.between(from: 1, to: 5) }
    let(:input_values) { { key: 'test' } }
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesCreateByUtilityWorker }
    let(:method) { :workflow_responses_create }
    let(:args) { [utility_id, workflow_code, input_values] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.create_params' do
    let(:workflow_code) { 12 }
    let(:input_values) { { key: 'test' } }
    let(:service_params) { described_class.create_params(utility_id, workflow_code, input_values) }
    let(:expected_params) do
      {
        body_params: { workflow_code: workflow_code, input_values: input_values }
      }.merge(expected_headers)
    end

    it_behaves_like 'returns the expected service response params'
  end

  describe '.build_body_params' do
    let(:build_body_params) { described_class.build_body_params(workflow_code, input_values) }
    let(:input_values) { { key: 'test' } }

    context 'when workflow_code is present' do
      let(:workflow_code) { 12 }
      let(:expected_body) do
        {
          body_params: { workflow_code: workflow_code, input_values: input_values }
        }
      end

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end

    context 'when workflow_code is not present' do
      let(:workflow_code) { nil }
      let(:expected_body) { { body_params: { input_values: input_values } } }

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end
  end

  describe '.workflow_responses_update' do
    let(:workflow_response_id) { Faker::Number.between(from: 1, to: 5) }
    let(:input_values) { { key: 'test' } }
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesUpdateByUtilityWorker }
    let(:method) { :workflow_responses_update }
    let(:args) { [utility_id, workflow_response_id, input_values] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.update_params' do
    let(:workflow_response_id) { 1 }
    let(:input_values) { { key: 'test' } }
    let(:service_params) do
      described_class.update_params(utility_id, workflow_response_id, input_values)
    end
    let(:expected_params) do
      {
        body_params: { input_values: input_values },
        uri_params: { id: workflow_response_id }
      }.merge(expected_headers)
    end

    it_behaves_like 'returns the expected service response params'
  end

  describe '.build_update_params' do
    let(:build_update_params) do
      described_class.build_update_params(workflow_response_id, input_values)
    end
    let(:input_values) { { key: 'test' } }
    let(:workflow_response_id) { 1 }
    let(:expected_result) do
      {
        body_params: { input_values: input_values },
        uri_params: { id: workflow_response_id }
      }
    end

    it 'returns the expected body' do
      expect(build_update_params).to eq(expected_result)
    end
  end

  describe '.workflow_responses_destroy' do
    let(:workflow_response_id) { Faker::Number.between(from: 1, to: 5) }
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesDestroyByUtilityWorker }
    let(:method) { :workflow_responses_destroy }
    let(:args) { [utility_id, workflow_response_id] }

    it_behaves_like 'successful instancing of worker'
  end
end
