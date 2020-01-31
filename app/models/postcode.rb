require 'net/http'
require 'pry-rails'

class Postcode
  URL = 'http://postcodes.io'
  WHITELISTED_LSOA = %w(Southwark Lambeth)
  
  attr_reader :response

  def initialize(postcode)
    @response = nil
    @postcode = postcode
  end

  def is_valid?
    fetch_response = fetch_postcode_data
    @response = JSON.parse(fetch_response.body)
    return fetch_response.kind_of?(Net::HTTPSuccess) && @response["result"]["lsoa"].start_with?(*WHITELISTED_LSOA)
  end

  def fetch_postcode_data
    uri = URI("#{URL}/postcodes/#{@postcode}")
    return Net::HTTP.get_response(uri)
  end

  def whitelisted_postcode?(postcode)
    return WhitelistedPostcode.check?(postcode)
  end
end
