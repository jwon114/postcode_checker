require 'test_helper'
require 'pry-rails'

class WhitelistedPostcodeTest < ActiveSupport::TestCase
  test '#check - first postcode is whitelisted' do
    postcode = whitelisted_postcodes(:one).postcode

    assert WhitelistedPostcode.check?(postcode)
  end

  test '#check - second postcode is whitelisted' do
    postcode = whitelisted_postcodes(:two).postcode

    assert WhitelistedPostcode.check?(postcode)
  end

  test '#check - postcode is not whitelisted' do
    postcode = 'ABC123'

    assert_not WhitelistedPostcode.check?(postcode)
  end
end
