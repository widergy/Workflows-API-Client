shared_examples 'utility id header validation' do
  it 'raises ActionController::ParameterMissing exception' do
    expect { service }.to raise_error(ActionController::ParameterMissing)
  end
end
