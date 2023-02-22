require 'spec_helper'

describe WorkflowsApiClient do
  let(:utility_id) { Faker::Number.between(from: 1, to: 5) }
  let(:expected_headers) do
    {
      headers: {
        'Utility-ID': utility_id.to_s,
        'Content-Type': 'application/json'
      }
    }
  end
  let(:workflow_code) { Faker::Number.between(from: 1, to: 5) }
  let(:input_values) { { key: 'test' } }
  let(:user_external_id) { Faker::Number.between(from: 1, to: 10) }
  let(:account_external_id) { Faker::Number.between(from: 1, to: 10) }
  let(:workflow_response_id) { Faker::Number.between(from: 1, to: 5) }

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
    let(:show_params) { { test: Faker::Number.between(from: 1, to: 5) } }
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
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesShowByUtilityWorker }
    let(:method) { :workflow_responses_show }
    let(:args) { [utility_id, workflow_response_id] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.workflow_responses_create' do
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesCreateByUtilityWorker }
    let(:method) { :workflow_responses_create }
    let(:args) { [utility_id, workflow_code, input_values, user_external_id, account_external_id] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.create_params' do
    let(:service_params) do
      described_class.create_params(utility_id, workflow_code, input_values, external_params)
    end
    let(:external_params) { [user_external_id, account_external_id] }
    let(:expected_params) do
      {
        body_params: {
          workflow_code: workflow_code, input_values: input_values,
          user_external_id: user_external_id, account_external_id: account_external_id
        }
      }.merge(expected_headers)
    end

    it_behaves_like 'returns the expected service response params'
  end

  describe '.build_body_params' do
    let(:build_body_params) do
      described_class.build_body_params(workflow_code, external_params, input_values)
    end

    context 'when all params are present' do
      let(:external_params) { [user_external_id, account_external_id] }
      let(:expected_body) do
        {
          body_params: {
            workflow_code: workflow_code, input_values: input_values,
            user_external_id: user_external_id,
            account_external_id: account_external_id
          }
        }
      end

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end

    context 'when workflow_code and external_params are not present' do
      let(:build_body_params) do
        described_class.build_body_params(workflow_code, input_values)
      end
      let(:workflow_code) { nil }
      let(:expected_body) { { body_params: { input_values: input_values } } }

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end

    context 'when user_external_id is not present' do
      let(:external_params) { [nil, account_external_id] }
      let(:expected_body) do
        {
          body_params: {
            workflow_code: workflow_code, input_values: input_values,
            account_external_id: account_external_id
          }
        }
      end

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end

    context 'when account_external_id is not present' do
      let(:external_params) { [user_external_id, nil] }
      let(:expected_body) do
        {
          body_params: {
            workflow_code: workflow_code, input_values: input_values,
            user_external_id: user_external_id
          }
        }
      end

      it 'returns the expected body' do
        expect(build_body_params).to eq(expected_body)
      end
    end
  end

  describe '.workflow_responses_update' do
    let(:worker_class) { WorkflowsApiClient::WorkflowResponsesUpdateByUtilityWorker }
    let(:method) { :workflow_responses_update }
    let(:args) { [utility_id, workflow_response_id, input_values] }

    it_behaves_like 'successful instancing of worker'
  end

  describe '.update_params' do
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
end
