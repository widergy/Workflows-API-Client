shared_examples 'endpoint with polling and request headers recovery' do
  it 'recovers the request headers successfully' do
    expect(controller.request_headers[:headers]).to eq(headers)
  end

  it 'responds with accepted' do
    expect(response).to have_http_status(:accepted)
  end

  it 'returns the response id and url to retrive the data later' do
    expect(response.parsed_body.keys).to contain_exactly('response', 'job_id', 'url')
  end
end
