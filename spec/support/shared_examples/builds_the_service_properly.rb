shared_examples 'successful service build' do
  it 'successful service build' do
    expect(worker_instance.send(:build_service).stringify_keys)
      .to eq(expected_service)
  end
end
