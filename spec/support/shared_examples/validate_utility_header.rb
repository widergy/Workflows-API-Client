shared_examples 'validates the presence of the utility id header' do
  it 'raises ActionController::ParameterMissing exception' do
    expect { service }.to raise_error(ActionController::ParameterMissing)
  end
end
