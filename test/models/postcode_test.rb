require 'test_helper'
require 'net/http'
require 'pry-rails'

class PostcodeTest < ActiveSupport::TestCase
  test '#fetch_postcode_data - successful fetch' do
    postcode = Postcode.new('SE17QD')
    fetch_response = postcode.send(:fetch_postcode_data)

    assert fetch_response.kind_of?(Net::HTTPSuccess)
  end

  test '#fetch_postcode_data - unsuccessful fetch' do
    postcode = Postcode.new('invalid_postcode')
    fetch_response = postcode.send(:fetch_postcode_data)

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

  test '#whitelisted_postcode? - postcode is whitelisted' do
    postcode = Postcode.new('SH241AA')

    assert postcode.send(:whitelisted_postcode?)
  end

  test '#whitelisted_postcode? - postcode is not whitelisted' do
    postcode = Postcode.new('Not whitelisted postcode')

    assert_not postcode.send(:whitelisted_postcode?)
  end

  test '#input_valid? - valid postcode input' do
    postcode = Postcode.new('SE17QD')

    assert postcode.send(:input_valid?)
  end

  test '#input_valid? - valid postcode input with spaces and lowercase' do
    postcode = Postcode.new(' se 17 QD')

    assert postcode.send(:input_valid?)
  end

  test '#input_valid? - invalid postcode input' do
    postcode = Postcode.new('!" #$ %^')

    assert_not postcode.send(:input_valid?)
  end
end