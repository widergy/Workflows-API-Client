require 'spec_helper'

describe WorkflowsApiClient::BaseWorker do
  let(:workflows_api_url) { 'https://api.example.com/workflows' }

  before do
    allow(WorkflowsApiClient).to receive(:config).and_return({ workflows_api_url: workflows_api_url })
  end

  context 'when the URL is configured' do
    it 'does not throw an exception' do
      expect { described_class.new }.not_to raise_error
    end
  end

  context 'when the URL is not configured' do
    let(:workflows_api_url) { '' }

    it 'throws an exception' do
      expect { described_class.new }.to raise_error(WorkflowsApiClient::Exceptions::InvalidConfiguration)
    end
  end
end
