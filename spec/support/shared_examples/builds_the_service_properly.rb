shared_examples 'successfuly builds service' do
  it 'successfuly builds service' do
    expect(worker_instance.send(:build_service).stringify_keys)
      .to eq(expected_service)
  end
end
