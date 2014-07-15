class Marko::Response
  class Error < StandardError
    attr_reader :response

    def initialize(response)
      @response = response
      super({status: response.status, headers: response.headers, body: response.body}.inspect)
    end
  end

  BadRequest    = Class.new(Error)
  NotFound      = Class.new(Error)
  Unprocessable = Class.new(Error)
  Conflict      = Class.new(Error)
  Unexpected    = Class.new(Error)

  EXCEPTION_MAPPING = {
    400 => BadRequest,
    404 => NotFound,
    409 => Conflict,
    422 => Unprocessable,
    500 => Unexpected,
  }

  attr_reader :headers, :status, :body

  def initialize(status, headers, body)
    @status, @headers, @body = status, headers, body
  end

  def successful?
    self.status < 300 && self.status > 199 || self.status == 304
  end

  def raise!
    if !successful?
      raise((EXCEPTION_MAPPING[self.status] || Error).new(self))
    else
      self
    end
  end
end
