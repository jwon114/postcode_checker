require 'test_helper'
require 'net/http'
require 'pry-rails'

class PostcodeTest < ActiveSupport::TestCase
  test '#is_valid? - API response 404 status, invalid postcode' do
    postcode = Postcode.new('invalid_postcode')
    postcode.is_valid?
    
    assert_response :missing
  end

  test '#is_valid? - API response contains LSOA Southwark' do
    postcode = Postcode.new('SE17QD')
    postcode.is_valid?
    
    assert_response :success
    assert postcode.result["lsoa"].start_with?('Southwark')
  end

  test '#is_valid? - API response contains LSOA Lambeth' do
    postcode = Postcode.new('SE17QA')
    postcode.is_valid?

    assert_response :success
    assert postcode.result["lsoa"].start_with?('Lambeth')
  end

  # test '#validate - valid postcode input' do
  #   postcode = 'SE17QD'

  # end
end