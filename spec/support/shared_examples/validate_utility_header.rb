shared_examples 'responds with the exception of missing parameters' do
  it 'raises ActionController::ParameterMissing exception' do
    expect { service }.to raise_error(ActionController::ParameterMissing)
  end
end
