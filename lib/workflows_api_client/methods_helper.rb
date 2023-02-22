module WorkflowsApiClient
  def self.request_headers(utility_id)
    {
      headers: {
        'Utility-ID': utility_id.to_s,
        'Content-Type': 'application/json'
      }
    }
  end

  def self.uri_params(utility_id, uri_params)
    add_headers({ uri_params: uri_params }, utility_id)
  end

  def self.index_response_params(utility_id, filters)
    add_headers({ query_params: filters }, utility_id)
  end

  def self.create_params(utility_id, workflow_code, input_values, external_params)
    add_headers(build_body_params(workflow_code, external_params, input_values), utility_id)
  end

  def self.update_params(utility_id, workflow_response_id, input_values)
    add_headers(build_update_params(workflow_response_id, input_values), utility_id)
  end

  def self.build_update_params(workflow_response_id, input_values)
    build_body_params(input_values).merge(
      { uri_params: { id: workflow_response_id } }
    )
  end

  def self.build_body_params(workflow_code = nil, external_params = [], input_values)
    user_external_id, account_external_id = external_params
    {
      body_params: {
        workflow_code: workflow_code, input_values: input_values,
        user_external_id: user_external_id, account_external_id: account_external_id
      }.compact
    }
  end

  def self.add_headers(service_params, utility_id)
    service_params.merge(request_headers(utility_id))
  end
end
