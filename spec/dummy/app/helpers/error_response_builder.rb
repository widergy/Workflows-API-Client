class ErrorResponseBuilder
  attr_reader :status, :payload, :utility

  def initialize(status = nil, utility = nil)
    @status = status
    @payload = { errors: [] }
    @utility = utility
  end

  def add_error(identifier, message: nil, meta: nil)
    payload[:errors] << {
      status: status,
      code: identifier,
      message: message,
      meta: meta
    }
    self
  end

  # For using in workers to return the error response
  def to_a
    [status, payload]
  end
end
