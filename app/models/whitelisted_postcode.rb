class WhitelistedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true

  def self.check?(postcode)
    return WhitelistedPostcode.exists?(postcode: postcode)
  end
end
