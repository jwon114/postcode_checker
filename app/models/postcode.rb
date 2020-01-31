require 'net/http'
require 'pry-rails'

class Postcode
  URL = 'http://postcodes.io'
  VALID_LSOA = %w(Southwark Lambeth)
  
  attr_reader :response

  def initialize(postcode)
    @response = nil
    @postcode = postcode
  end

  def is_valid?
    fetch_response = fetch_postcode_data
    @response = JSON.parse(fetch_response.body)
    return @response.kind_of?(Net::HTTPSuccess) && @result["lsoa"].start_with?(*VALID_LSOA)
  end

  def fetch_postcode_data
    uri = URI("#{URL}/postcodes/#{@postcode}")
    return Net::HTTP.get_response(uri)
  end
end
