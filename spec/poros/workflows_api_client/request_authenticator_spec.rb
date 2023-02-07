require 'spec_helper'

describe WorkflowsApiClient::RequestAuthenticator do
  subject { described_class.new  }

  let(:api_key) { 'test_api_key' }
  let(:api_secret) { 'test_api_secret' }
  let(:config) do
    {
      consumer_api_key: api_key,
      consumer_api_secret: api_secret
    }
  end

  before do
    allow(WorkflowsApiClient).to receive(:config).and_return(config)
  end

  describe '#perform' do
    shared_examples 'raises an InvalidConfiguration error' do
      it 'raises with the appropriate message' do
        expect { subject.perform }
          .to raise_error(WorkflowsApiClient::Exceptions::InvalidConfiguration) do |exception|
          expect(exception.message).to eq(error_message)
        end
      end
    end

    it 'returns an instance of AuthenticationHeaders' do
      expect(subject.perform).to be_an_instance_of(described_class)
    end

    it 'sets the key and digest instance variables' do
      subject.perform
      expect(subject.key).to be_present
      expect(subject.digest).to be_present
    end

    context 'when the configuration is missing' do
      let(:config) do
        {
          consumer_api_secret: '',
          consumer_api_key: ''
        }
      end

      it_behaves_like 'raises an InvalidConfiguration error' do
        let(:error_message) do
          'The consumer_api_key and consumer_api_secret configuration is not defined or is invalid'
        end
      end
    end

    context 'when the api_key is missing from the configuration' do
      let(:config) do
        {
          consumer_api_secret: api_secret,
          consumer_api_key: ''
        }
      end

      it_behaves_like 'raises an InvalidConfiguration error' do
        let(:error_message) do
          'The consumer_api_key configuration is not defined or is invalid'
        end
      end
    end

    context 'when the api_secret is missing from the configuration' do
      let(:config) do
        {
          consumer_api_key: api_key,
          consumer_api_secret: ''
        }
      end

      it_behaves_like 'raises an InvalidConfiguration error' do
        let(:error_message) do
          'The consumer_api_secret configuration is not defined or is invalid'
        end
      end
    end
  end
end
