require 'test_helper'
require 'net/http'

class PostcodeValidatorTest < ActiveSupport::TestCase
  test '#fetch_postcode_data - successful fetch' do
    postcode = PostcodeValidator.new('SE17QD')
    fetch_response = postcode.fetch_postcode_data

    assert fetch_response.kind_of?(Net::HTTPSuccess)
  end

  test '#fetch_postcode_data - unsuccessful fetch' do
    postcode = PostcodeValidator.new('invalid_postcode')
    fetch_response = postcode.fetch_postcode_data

    assert_not fetch_response.kind_of?(Net::HTTPSuccess)
  end

  test '#is_valid? - postcode is not within Southwark or Lambeth' do
    postcode = PostcodeValidator.new('N102RE')
    
    assert_not postcode.is_valid?
  end

  test '#is_valid? - API response contains LSOA Southwark' do
    postcode = PostcodeValidator.new('SE17QD')
    
    assert postcode.is_valid?
  end

  test '#is_valid? - API response contains LSOA Lambeth' do
    postcode = PostcodeValidator.new('SE17QA')

    assert postcode.is_valid?
  end

  test '#is_valid? - whitelisted postcode SH241AA' do
    postcode = PostcodeValidator.new('SH241AA')

    assert postcode.is_valid?
  end

  test '#is_valid? - whitelisted postcode SH241AB' do
    postcode = PostcodeValidator.new('SH241AB')

    assert postcode.is_valid?
  end

  test '#whitelisted_postcode? - postcode one is whitelisted' do
    code = whitelisted_postcodes(:one).postcode
    postcode = PostcodeValidator.new(code)

    assert postcode.whitelisted_postcode?
  end

  test '#whitelisted_postcode? - postcode two is whitelisted' do
    code = whitelisted_postcodes(:two).postcode
    postcode = PostcodeValidator.new(code)

    assert postcode.whitelisted_postcode?
  end

  test '#whitelisted_postcode? - postcode is not whitelisted' do
    postcode = PostcodeValidator.new('Not whitelisted postcode')

    assert_not postcode.whitelisted_postcode?
  end

  test '#input_valid? - valid postcode input' do
    postcode = PostcodeValidator.new('SE17QD')

    assert postcode.input_valid?
  end

  test '#input_valid? - valid postcode input with spaces and lowercase' do
    postcode = PostcodeValidator.new(' se 17 QD')

    assert postcode.input_valid?
  end

  test '#input_valid? - invalid postcode input' do
    postcode = PostcodeValidator.new('!" #$ %^')

    assert_not postcode.input_valid?
  end
end