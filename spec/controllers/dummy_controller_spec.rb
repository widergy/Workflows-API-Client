require 'spec_helper'

describe DummyController, type: :controller do
  describe 'route configurations', type: :routing do
    context 'when the configured services_namespace is custom' do
      let!(:configured_namespace) { WorkflowsApiClient.config[:services_namespace] }

      it 'the route matches the configured namespace' do
        expect(get("/#{configured_namespace}/workflows"))
          .to route_to('workflows_api_client/workflows#index')
      end
    end
  end

  describe 'controller configuration to be inherited' do
    context 'when the configured controller_to_inherit_authentication is custom' do
      it { expect(WorkflowsApiClient::WorkflowsController).to be < DummyFatherController }
    end

    context 'when the configured controller_to_inherit_authentication is invalid' do
      let(:controller_to_inherit_authentication) { 'InvalidController' }

      before do
        allow(WorkflowsApiClient).to receive(:config)
          .and_return({ controller_to_inherit_authentication: controller_to_inherit_authentication })
      end

      it 'raises InvalidConfiguration error' do
        expect { WorkflowsApiClient::ControllerInheritanceHelper.inherit }
          .to raise_error(WorkflowsApiClient::Exceptions::InvalidConfiguration)
      end
    end
  end
end
