class ErrorResponseBuilder
  attr_reader :status, :payload, :utility

  def initialize(status = nil, utility = nil)
    @status = status
    @payload = { errors: [] }
    @utility = utility
  end

  def add_status(status)
    @status = status_code(status)
    self
  end

  def add_error(identifier, message: nil, meta: nil)
    payload[:errors] << {
      status: status_code(status),
      code: identifier,
      message: message,
      meta: meta
    }
    self
  end

  # For using in workers to return the error response
  def to_a
    [status, to_h]
  end
end
