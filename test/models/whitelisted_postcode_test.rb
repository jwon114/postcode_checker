require 'test_helper'
require 'pry-rails'

class WhitelistedPostcodeTest < ActiveSupport::TestCase
  WHITELISTED_POSTCODES = %w(SH241AA SH241AB)

  test '#check - first postcode is whitelisted' do
    postcode = WHITELISTED_POSTCODES.first

    assert WhitelistedPostcode.check?(postcode)
  end

  test '#check - second postcode is whitelisted' do
    postcode = WHITELISTED_POSTCODES.second

    assert WhitelistedPostcode.check?(postcode)
  end

  test '#check - postcode is not whitelisted' do
    postcode = 'ABC123'

    assert_not WhitelistedPostcode.check?(postcode)
  end
end
