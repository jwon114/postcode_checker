require 'test_helper'

class WhitelistedPostcodeTest < ActiveSupport::TestCase
  test '#normalize - remove whitespace and upcase letters in postcode' do
    whitelisted_postcode = WhitelistedPostcode.new
    whitelisted_postcode.postcode = 'sh24 1aa'
    whitelisted_postcode.send(:normalize_postcode)

    assert_equal whitelisted_postcode.postcode, 'SH241AA'
  end

  test 'postcode is normalized when saved in database' do
    whitelisted_postcode = WhitelistedPostcode.new
    whitelisted_postcode.postcode = 'sh24 1 a b'
    whitelisted_postcode.save

    assert_equal whitelisted_postcode.postcode, 'SH241AB'
  end
end
