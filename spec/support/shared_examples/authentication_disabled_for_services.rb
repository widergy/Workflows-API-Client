shared_examples 'authentication disabled service' do
  before do
    request.headers.merge(headers)
  end

  it 'does not throw an error because it does not call the method' do
    expect_any_instance_of(DummyFatherController).not_to receive(:authenticate_request)
    service
  end
end
