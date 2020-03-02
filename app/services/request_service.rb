require 'net/http'

class RequestService
  URL = 'http://postcodes.io'
  RESPONSE_CODES = [Net::HTTPSuccess, Net::HTTPNotFound]

  def self.fetch(postcode: nil)
    uri = URI("#{URL}/postcodes/#{postcode}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body).with_indifferent_access if RESPONSE_CODES.any? { |s| response.kind_of?(s) }
  end
end