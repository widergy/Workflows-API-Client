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
    add_headers({ uri_params: { code: code } }, utility_id)
  end

  def self.index_response_params(utility_id, filters)
    add_headers({ query_params: filters }, utility_id)
  end

  def self.add_headers(service_params, utility_id)
    service_params.merge(request_headers(utility_id))
  end
end
