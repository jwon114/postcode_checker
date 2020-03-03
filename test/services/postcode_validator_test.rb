require 'test_helper'
require 'pry-rails'

class PostcodeValidatorTest < ActiveSupport::TestCase
  # test '#self.is_valid? - postcode is not within Southwark or Lambeth' do
  #   postcode_validator = PostcodeValidator.is_valid?(postcode: 'N102RE')
    
  #   assert_not postcode_validator[:valid]
  # end

  # test '#self.is_valid? - API response contains LSOA Southwark' do
  #   postcode_validator = PostcodeValidator.is_valid?(postcode: 'SE17QD')
    
  #   assert postcode_validator[:valid]
  # end

  # test '#self.is_valid? - API response contains LSOA Lambeth' do
  #   postcode_validator = PostcodeValidator.is_valid?(postcode: 'SE17QA')
    
  #   assert postcode_validator[:valid]
  # end

  # test '#self.is_valid? - whitelisted postcode SH241AA' do
  #   postcode_validator = PostcodeValidator.is_valid?(postcode: 'SH241AA')

  #   assert postcode_validator[:valid]
  # end

  test '#self.is_valid? - whitelisted postcode SH241AB' do
    postcode_validator = PostcodeValidator.is_valid?(postcode: 'SH241AB')
    binding.pry
    assert postcode_validator[:valid]
  end

  # test '#whitelisted_postcode? - postcode one is whitelisted' do
  #   code = whitelisted_postcodes(:one).postcode
  #   is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, postcode: code)

  #   assert is_whitelisted
  # end

  # test '#whitelisted_postcode? - postcode two is whitelisted' do
  #   code = whitelisted_postcodes(:two).postcode
  #   is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, postcode: code)

  #   assert is_whitelisted
  # end

  # test '#whitelisted_postcode? - postcode is not whitelisted' do
  #   is_whitelisted = PostcodeValidator.send(:whitelisted_postcode?, postcode: 'Not whitelisted postcode')

  #   assert_not is_whitelisted
  # end

  # test '#response_handler - postcode is valid, success message' do
  #   postcode = 'SE17QD'
  #   response = JSON.parse(File.read('./test/fixtures/files/valid_postcode_data.json')).with_indifferent_access
  #   result = PostcodeValidator.send(:response_handler, response: response, postcode: postcode)

  #   expected_result = { valid: true, status: { type: :notice, message: "Postcode '#{postcode}' is within your service area"} }
  #   assert_equal result, expected_result
  # end

  # test '#response_handler - postcode input is invalid, error from response' do
  #   postcode = 'invalid postcode'

  #   response = JSON.parse(File.read('./test/fixtures/files/invalid_postcode_input.json')).with_indifferent_access
  #   result = PostcodeValidator.send(:response_handler, response: response, postcode: postcode)

  #   expected_result = { valid: false, status: { type: :error, message: response[:error]} }
  #   assert_equal result, expected_result
  # end

  # test' #response_handler - postcode is invalid, not within service area' do
  #   postcode = 'N102RE'
  #   response = JSON.parse(File.read('./test/fixtures/files/invalid_postcode_data.json')).with_indifferent_access
  #   result = PostcodeValidator.send(:response_handler, response: response, postcode: postcode)

  #   expected_result = { valid: false, status: { type: :error, message: "Postcode '#{postcode}' is NOT within your service area"} }
  #   assert_equal result, expected_result
  # end
end