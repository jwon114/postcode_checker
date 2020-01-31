class Postcode
  URL = 'http://postcodes.io'
  attr_reader :result, :postcode

  def initialize(postcode)
    @result = nil
    @postcode = postcode
  end

  def is_valid?
  end

  private

  def build_postcode_url(postcode)
    return "#{URL}/postcodes/#{postcode}"
  end
end
