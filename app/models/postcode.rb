require 'net/http'
require 'pry-rails'

class Postcode
  URL = 'http://postcodes.io'
  VALID_LSOA = %w(Southwark Lambeth)
  
  attr_reader :result

  def initialize(postcode)
    @response = nil
    @postcode = postcode
    @result = nil
  end

  def is_valid?
    return false if @response.nil?
    return true if @response.kind_of?(Net::HTTPSuccess) && @result["lsoa"].start_with?(*VALID_LSOA)
  end

  def fetch_postcode_data
    uri = URI("#{URL}/postcodes/#{@postcode}")
    @response = Net::HTTP.get_response(uri)
    response_body = JSON.parse(@response.body)
    @result = is_valid? ? response_body["result"] : response_body
  end
end
