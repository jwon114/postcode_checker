class WhitelistedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true
  before_save :normalize_postcode

  private

  def normalize_postcode
    self.postcode = self.postcode.gsub(/\s+/, "").upcase
  end
end
