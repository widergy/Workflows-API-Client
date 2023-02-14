shared_examples 'returns the expected service response params' do
  it 'returns service params' do
    expect(service_params).to eq(expected_params)
  end
end
