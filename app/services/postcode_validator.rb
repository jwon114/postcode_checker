class PostcodeValidator
  WHITELISTED_LSOA = %w(Southwark Lambeth)

  def self.is_valid?(postcode: nil)
    valid_input = InputValidator.validate(input: postcode)
    return false unless valid_input # TODO, fix with returning hash
    return true if whitelisted_postcode?(postcode: postcode) # TODO, fix with returning hash

    response = RequestService.fetch(postcode: postcode)
    return response_handler(response: response, postcode: postcode)
  end

  private
    
  def self.whitelisted_postcode?(postcode: nil)
    WhitelistedPostcode.exists?(postcode: postcode)
  end

  def self.response_handler(response: nil, postcode: postcode)
    result = { valid: false, status: {} }

    result[:valid] = response[:result].present? ? response.dig(:result, :lsoa).start_with?(*WHITELISTED_LSOA) : false
    if result[:valid]
      type = :notice
      message = "Postcode '#{postcode}' is within your service area"
    elsif response.has_key?("error")
      type = :error
      message = response[:error]
    else
      type = :error
      message = "Postcode '#{postcode}' is NOT within your service area"
    end

    result[:status] = { type: type, message: message} 
    return result
  end
end
