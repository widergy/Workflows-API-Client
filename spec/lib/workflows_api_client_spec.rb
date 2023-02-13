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

  describe '.request_headers' do
    let(:headers) { described_class.request_headers(utility_id) }

    it 'returns the expected request headers' do
      expect(headers).to eq({ headers: {
                              'Utility-ID': utility_id.to_s,
                              'Content-Type': 'application/json'
                            } })
    end
  end
end
