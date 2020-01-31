require 'test_helper'
require 'net/http'
require 'pry-rails'

class PostcodeTest < ActiveSupport::TestCase
  test '#fetch_postcode_data - successful fetch' do
    postcode = Postcode.new('SE17QD')
    fetch_response = postcode.fetch_postcode_data

    assert fetch_response.kind_of?(Net::HTTPSuccess)
  end

  test '#fetch_postcode_data - unsuccessful fetch' do
    postcode = Postcode.new('invalid_postcode')
    fetch_response = postcode.fetch_postcode_data

    assert_not fetch_response.kind_of?(Net::HTTPSuccess)
  end

  test '#is_valid? - postcode is not within Southwark or Lambeth' do
    postcode = Postcode.new('N102RE')
    
    assert_not postcode.is_valid?
  end

  test '#is_valid? - API response contains LSOA Southwark' do
    postcode = Postcode.new('SE17QD')
    
    assert postcode.is_valid?
  end

  test '#is_valid? - API response contains LSOA Lambeth' do
    postcode = Postcode.new('SE17QA')

    assert postcode.is_valid?
  end

  test '#is_valid? - whitelisted postcode SH241AA' do
    postcode = Postcode.new('SH241AA')

    assert postcode.is_valid?
  end

  test '#is_valid? - whitelisted postcode SH241AB' do
    postcode = Postcode.new('SH241AB')

    assert postcode.is_valid?
  end

  # test '#input_valid? - valid postcode input' do
  #   postcode = Postcode.new('SE17QD')

  #   assert postcode.input_valid?
  # end

  # test '#input_valid? - invalid postcode input' do
  #   postcode = Postcode.new('!"#$%^')

  #   assert_not postcode.input_valid?
  # end
end