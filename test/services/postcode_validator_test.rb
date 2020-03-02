require 'test_helper'

class PostcodeValidatorTest < ActiveSupport::TestCase
  test '#self.is_valid? - postcode is not within Southwark or Lambeth' do
    valid_postcode = PostcodeValidator.is_valid?(postcode: 'N102RE')
    
    assert_not valid_postcode
  end

  test '#self.is_valid? - API response contains LSOA Southwark' do
    valid_postcode = PostcodeValidator.is_valid?(postcode: 'SE17QD')
    
    assert valid_postcode
  end

  test '#self.is_valid? - API response contains LSOA Lambeth' do
    valid_postcode = PostcodeValidator.is_valid?(postcode: 'SE17QA')
    
    assert valid_postcode
  end

  test '#self.is_valid? - whitelisted postcode SH241AA' do
    valid_postcode = PostcodeValidator.is_valid?(postcode: 'SH241AA')

    assert valid_postcode
  end

  test '#self.is_valid? - whitelisted postcode SH241AB' do
    valid_postcode = PostcodeValidator.is_valid?(postcode: 'SH241AB')

    assert valid_postcode
  end

  test '#whitelisted_postcode? - postcode one is whitelisted' do
    code = whitelisted_postcodes(:one).postcode
    is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, code)

    assert is_whitelisted
  end

  test '#whitelisted_postcode? - postcode two is whitelisted' do
    code = whitelisted_postcodes(:two).postcode
    is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, code)

    assert is_whitelisted
  end

  test '#whitelisted_postcode? - postcode is not whitelisted' do
    is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, 'Not whitelisted postcode')

    assert_not is_whitelisted
  end
end