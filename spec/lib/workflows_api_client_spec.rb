require 'spec_helper'

describe WorkflowsApiClient do
  describe '.workflows_index' do
    let(:utility_id) { 123 }

    it 'creates a new instance of WorkflowsIndexByUtilityWorker' do
      expect(WorkflowsApiClient::WorkflowsIndexByUtilityWorker).to receive(:new).and_call_original
      described_class.workflows_index(utility_id)
    end
  end

  describe '.request_headers' do
    let(:utility_id) { 123 }

    it 'returns the expected request headers' do
      headers = described_class.request_headers(utility_id)
      expect(headers).to eq({ headers: {
                              'Utility-ID': '123',
                              'Content-Type': 'application/json'
                            } })
    end
  end
end
