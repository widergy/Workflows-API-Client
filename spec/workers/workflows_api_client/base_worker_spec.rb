require 'spec_helper'

describe WorkflowsApiClient::BaseWorker do
  let(:workflows_api_url) { 'https://api.example.com/workflows' }

  describe 'initialize' do
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

  describe 'execute' do
    subject { described_class.new.execute({}) }

    context 'when an error is present' do
      let(:error_response_builder_instance) { instance_double(ErrorResponseBuilder) }

      before do
        allow_any_instance_of(described_class).to receive(:perform).and_raise(StandardError)
        allow_any_instance_of(ErrorResponseBuilder).to receive(:add_error).and_return(error_response_builder_instance)
        allow(error_response_builder_instance).to receive(:to_a).and_return([:status_code, {}])
      end

      it 'calls ErrorBuilderHelper' do
        expect_any_instance_of(ErrorResponseBuilder).to receive(:add_error).and_call_original
        subject
      end
    end
  end
end
