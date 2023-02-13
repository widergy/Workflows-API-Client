module WorkflowsApiClient
  def self.request_headers(utility_id)
    {
      headers: {
        'Utility-ID': utility_id.to_s,
        'Content-Type': 'application/json'
      }
    }
  end

  def self.show_params(utility_id, code)
    { uri_params: { code: code } }.merge(request_headers(utility_id))
  end
end
