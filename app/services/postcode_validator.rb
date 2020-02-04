require 'net/http'

class PostcodeValidator
  URL = 'http://postcodes.io'
  WHITELISTED_LSOA = %w(Southwark Lambeth)
  RESPONSE_CODES = [Net::HTTPSuccess, Net::HTTPNotFound]
  
  attr_reader :response, :postcode

  def initialize(postcode)
    @response = nil
    @postcode = postcode.gsub(/\s+/, "").upcase
  end

  def is_valid?
    return false unless input_valid? || @response.present?
    return true if whitelisted_postcode?
    return @response[:result].present? ? @response.dig(:result, :lsoa).start_with?(*WHITELISTED_LSOA) : false
  end

  def input_valid?
    return /^[a-zA-Z0-9]*$/.match?(@postcode)
  end

  def fetch_postcode_data
    uri = URI("#{URL}/postcodes/#{@postcode}")
    response = Net::HTTP.get_response(uri)
    @response = JSON.parse(response.body).with_indifferent_access if RESPONSE_CODES.any? { |s| response.kind_of?(s) }
  end

  def whitelisted_postcode?
    return WhitelistedPostcode.exists?(postcode: @postcode)
  end
end
