require 'test_helper'

class PostcodeCheckerControllerTest < ActionDispatch::IntegrationTest
  test '#index - should get index' do
    get postcode_checker_url
    
    assert_response :success
  end

  test '#check - should check whitelisted postcode and flash notice' do
    post postcode_checker_check_url, params: { postcode: 'SE17QD' }

    assert_redirected_to postcode_checker_url
    assert_equal "Postcode 'SE17QD' is within your service area", flash[:notice]
  end

  test '#check - invalid postcode and flash error' do
    post postcode_checker_check_url, params: { postcode: 'ABC123' }

    assert_redirected_to postcode_checker_url
    assert_equal "Invalid postcode", flash[:error]
  end

  test '#check - should check non whitelisted postcode and flash error' do
    post postcode_checker_check_url, params: { postcode: 'OX49 5NU' }

    assert_redirected_to postcode_checker_url
    assert_equal "Postcode 'OX495NU' is NOT within your service area", flash[:error]
  end
end