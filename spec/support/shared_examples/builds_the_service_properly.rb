shared_examples 'builds the service properly' do
  it 'builds the service properly' do
    expect(worker_instance.send(:build_service).stringify_keys)
      .to eq(expected_service)
  end
end
