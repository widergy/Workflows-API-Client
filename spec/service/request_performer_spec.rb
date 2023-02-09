require 'spec_helper'

RSpec.describe WorkflowsApiClient::RequestPerformer do
  shared_examples 'successful service response' do
    it 'returns status ok' do
      expect(perform_service.code).to eq(200)
    end
  end

  shared_examples 'service request error response' do
    it 'returns the expected error status' do
      expect(perform_service.code).to eq(error_status_code)
    end

    it 'returns the expected error message' do
      expect(perform_service.body).to eq(expected_error_response)
    end
  end

  describe '#perform' do
    subject(:perform_service) do
      VCR.use_cassette 'request_performer/successful_response' do
        described_class.new(service).perform
      end
    end

    let(:service) do
      {
        http_method: http_method, body_params: body_params, headers: headers,
        query_params: query_params, uri_params: uri_params, url: url
      }
    end

    let(:http_method) { :get }
    let(:body_params) { nil }
    let(:headers) { { 'Utility-ID': '7' } }
    let(:query_params) { nil }
    let(:uri_params) { nil }
    let(:url) { WorkflowsApiClient.config[:workflows_api_url] + 'workflows' }

    context 'when the request is successful' do
      it_behaves_like 'successful service response'
    end

    context 'when the request is successful with failed result' do
      subject(:perform_service) do
        described_class.new(service).perform
      end

      let(:response) do
        instance_double('HTTParty::Response', code: error_code, parsed_response: {},
                                              body: nil, headers: nil)
      end
      let(:error_code) { 400 }

      before do
        allow(HTTParty).to receive(:send).and_return(response)
      end

      it 'returns a bad request status' do
        expect(perform_service.code).to eq(error_code)
      end
    end

    context 'when an exception occurs' do
      subject(:perform_service) do
        described_class.new(service).perform
      end

      before do
        allow(HTTParty).to receive(:send).and_raise(exception)
      end

      let(:expected_error_response) do
        { error: error_message }
      end

      context 'with timeout exceptions' do
        let(:exception) { Net::OpenTimeout }
        let(:error_message) { 'gateway_timeout' }
        let(:error_status_code) { 504 }

        it_behaves_like 'service request error response'
      end

      context 'with all http errors' do
        let(:exception) { [Net::HTTPBadResponse, Errno::ECONNRESET, OpenSSL::SSL::SSLError].sample }
        let(:error_message) { 'internal_server_error' }
        let(:error_status_code) { 500 }

        it_behaves_like 'service request error response'
      end

      context 'with ArgumentError' do
        let(:exception) { ArgumentError }
        let(:error_message) { 'service_unavailable' }
        let(:error_status_code) { 501 }

        it_behaves_like 'service request error response'
      end

      context 'with other standard error' do
        let(:exception) { StandardError }
        let(:error_message) { 'internal_server_error' }
        let(:error_status_code) { 500 }

        it_behaves_like 'service request error response'
      end
    end
  end

  describe '#formatted_headers' do
    subject(:formatted_headers) do
      described_class.new({ headers: {} }).send(:formatted_headers)
    end

    context 'when the configuration is fine' do
      it 'header key is present' do
        expect(subject[:key]).to be_present
      end

      it 'header digest is present' do
        expect(subject[:digest]).to be_present
      end
    end

    context 'when configuration is missing' do
      let(:invalid_config) do
        {
          workflows_api_url: 'workflows_api_url',
          consumer_api_key: '',
          consumer_api_secret: '',
          async_request_helper: 'AsyncRequest::ApplicationHelper',
          controller_to_inherit_authentication: 'ApplicationController',
          services_namespace: '',
          define_routes_manually: false
        }
      end

      before do
        allow(WorkflowsApiClient).to receive(:config).and_return(invalid_config)
      end

      it 'raises an InvalidConfiguration error' do
        expect { subject }.to raise_error(WorkflowsApiClient::Exceptions::InvalidConfiguration)
      end
    end
  end
end
