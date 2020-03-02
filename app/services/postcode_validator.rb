class PostcodeValidator
  WHITELISTED_LSOA = %w(Southwark Lambeth)

  def self.is_valid?(postcode: nil)
    valid_input = InputValidator.validate(input: postcode)
    return false unless valid_input
    return true if whitelisted_postcode?(postcode)
    
    response = RequestService.fetch(postcode: postcode)
    return response["result"].present? ? response.dig("result", "lsoa").start_with?(*WHITELISTED_LSOA) : false
  end

  private
    
  def self.whitelisted_postcode?(postcode)
    WhitelistedPostcode.exists?(postcode: postcode)
  end
end
