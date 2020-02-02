require 'test_helper'

class PostcodeCheckerControllerTest < ActionController::TestCase
  test '#index - should get index' do
    get :index
    
    assert_response :success
  end

  test '#check - should check whitelisted postcode and flash notice' do
    post :check, params: { postcode: 'SE17QD' }

    assert_redirected_to postcode_checker_url
    assert_equal 'Postcode is whitelisted', flash[:notice]
  end

  test '#check - should check non whitelisted postcode and flash error' do
    post :check, params: { postcode: 'ABC123' }

    assert_redirected_to postcode_checker_url
    assert_equal 'Postcode is NOT whitelisted', flash[:error]
  end
end