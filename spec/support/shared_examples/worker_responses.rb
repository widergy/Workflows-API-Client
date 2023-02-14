shared_examples 'successful worker response' do
  it 'return ok status' do
    expect(execute_worker.first).to eq(200)
  end

  it 'return the body response' do
    expect(execute_worker.second).to be_present
  end
end

shared_examples 'failed worker response' do
  let(:response) do
    instance_double('HTTParty::Response', code: error_code, parsed_response: {},
                                          body: nil, headers: nil)
  end
  let(:error_code) { 400 }

  before do
    allow(HTTParty).to receive(:send).and_return(response)
  end

  it 'returns a bad request status' do
    expect(execute_worker.first).to eq(error_code)
  end
end

shared_examples 'unhandled error from worker response' do
  before do
    allow(HTTParty).to receive(:send).and_raise(Net::OpenTimeout)
  end

  it 'returns error status' do
    expect(execute_worker.first).to be_present
  end

  it 'returns error message' do
    expect(execute_worker.second).to be_present
  end
end
