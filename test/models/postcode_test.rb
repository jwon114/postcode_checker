require 'test_helper'
require 'net/http'
require 'pry-rails'

class PostcodeTest < ActiveSupport::TestCase
  test '#is_valid? - API response 404 status, invalid postcode' do
    postcode = Postcode.new('invalid_postcode')
    
    assert_not postcode.is_valid?
    # assert_equal "Invalid postcode", postcode.result["error"]
  end

  test '#is_valid? - API response contains LSOA Southwark' do
    sample_valid_result = Postcode(:valid).json
    postcode = Postcode.new('SE17QD')
    
    assert postcode.is_valid?
    assert postcode.result["lsoa"].start_with?('Southwark')
  end

  test '#is_valid? - API response contains LSOA Lambeth' do
    postcode = Postcode.new('SE17QA')
    postcode.is_valid?

    assert postcode.is_valid?
    assert postcode.result["lsoa"].start_with?('Lambeth')
  end

  test '#fetch_postcode_data - successful fetch' do
    
  end

  test '#fetch_postcode_data - unsuccessful fetch' do
    postcode = Postcode.new('invalid_postcode')
    result = postcode.fetch_postcode_data
  
    assert_equal "Invalid postcode", result["error"]
  end

  test '#input_valid? - valid postcode input' do
    postcode = Postcode.new('SE17QD')

    assert postcode.input_valid?
  end

  test '#input_valid? - invalid postcode input' do
    postcode = Postcode.new('!"#$%^')

    assert_not postcode.input_valid?
  end
end