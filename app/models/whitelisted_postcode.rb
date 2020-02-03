class WhitelistedPostcode < ApplicationRecord
  validates :postcode, presence: true, uniqueness: true
end
