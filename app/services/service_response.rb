class ServiceResponse

  def initialize(success: false, message: nil, payload: nil)
    @success = success
    @message = message
    @wrapped_object = payload
  end

  def success?
    @success
  end

  def message
    @message
  end

  def unwrap
    @wrapped_object
  end

  def self.success
    ServiceResponse.new(success: true)
  end

  def self.success_with_payload(payload)
    ServiceResponse.new(success: true, message: nil, payload: payload)
  end

  def self.error
    ServiceResponse.new(success: false)
  end

  def self.error_with_message(message)
    ServiceResponse.new(success: false, message: message)
  end

end
