shared_examples 'creates a new instance of the relevant worker' do
  it 'creates a new instance' do
    expect(worker_class).to receive(:new).and_call_original
    described_class.send(method, *args)
  end
end
