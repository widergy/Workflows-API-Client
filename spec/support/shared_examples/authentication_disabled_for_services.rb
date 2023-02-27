shared_examples 'authentication disabled service' do
  before do
    request.headers.merge(headers)
    allow(DummyFatherController).to receive(:authenticate_request).and_raise(StandardError)
  end

  it 'does not throw an error because it does not call the method' do
    expect { service }.not_to raise_error
  end
end
