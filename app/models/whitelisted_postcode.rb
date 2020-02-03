class WhitelistedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true

  attr_accessor :postcode

  def self.check?(postcode)
    return WhitelistedPostcode.exists?(postcode: postcode)
  end

  def input_valid?
    return /^[a-zA-Z0-9]*$/.match?(@postcode)
  end
end
