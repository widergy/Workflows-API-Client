module WorkflowsApiClient
  def self.workflows_index(utility_id)
    WorkflowsIndexByUtilityWorker.new.execute(request_headers(utility_id))
  end

  def self.request_headers(utility_id)
    {
      headers: {
        'Utility-ID': utility_id.to_s,
        'Content-Type': 'application/json'
      }
    }
  end
end
