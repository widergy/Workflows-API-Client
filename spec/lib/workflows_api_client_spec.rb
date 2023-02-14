require 'spec_helper'

describe WorkflowsApiClient do
  let(:utility_id) { 123 }
  let(:worker_class) { WorkflowsApiClient::WorkflowsIndexByUtilityWorker }

  describe '.workflows_index' do
    it 'creates a new instance of WorkflowsIndexByUtilityWorker' do
      expect(worker_class).to receive(:new).and_call_original
      described_class.workflows_index(utility_id)
    end
  end

  describe '.workflows_show' do
    let(:utility_id) { 123 }
    let(:code) { 'test_code' }

    it 'creates a new instance of WorkflowsShowByUtilityWorker' do
      expect(WorkflowsApiClient::WorkflowsShowByUtilityWorker).to receive(:new).and_call_original
      described_class.workflows_show(utility_id, code)
    end
  end

  describe '.request_headers' do
    let(:headers) { described_class.request_headers(utility_id) }

    it 'returns the expected request headers' do
      expect(headers).to eq({ headers: {
                              'Utility-ID': utility_id.to_s,
                              'Content-Type': 'application/json'
                            } })
    end
  end

  describe '.show_params' do
    let(:utility_id) { 123 }
    let(:code) { 'test_code' }
    let(:show_params) { described_class.show_params(utility_id, code) }
    let(:expected_params) do
      {
        headers: {
          'Utility-ID': '123',
          'Content-Type': 'application/json'
        },
        uri_params: { code: code }
      }
    end

    it 'returns the expected show params' do
      expect(show_params).to eq(expected_params)
    end
  end
end
