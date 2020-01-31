require 'net/http'
require 'pry-rails'

class Postcode
  URL = 'http://postcodes.io'
  attr_reader :result

  def initialize(postcode)
    uri = URI("#{URL}/postcodes/#{postcode}")
    @response = Net::HTTP.get_response(uri)
    response_body = JSON.parse(@response.body)
    @result = is_valid? ? response_body["result"] : response_body
  end

  def is_valid?
    return @response.kind_of?(Net::HTTPSuccess)
  end
end
