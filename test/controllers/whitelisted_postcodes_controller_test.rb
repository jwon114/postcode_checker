require 'test_helper'
require 'pry-rails'

class WhitelistedPostcodesControllerTest < ActionController::TestCase
  test '#index - list all postcodes and options to add/remove' do
    get :index

    assert_response :success
    assert_equal WhitelistedPostcode.all, assigns(:postcodes)
  end

  test '#create - postcode is created on whitelist' do
    assert_difference 'WhitelistedPostcode.count' do
      post :create, params: { postcode: 'EC1A' }
    end
    
    assert_redirected_to whitelisted_postcodes_url
    assert_equal 'New Postcode EC1A Whitelisted', flash[:notice]
  end

  test '#create - postcode already exists on whitelist' do
    assert_no_difference 'WhitelistedPostcode.count' do
      post :create, params: { postcode: 'SH241AA' }
    end

    assert_redirected_to whitelisted_postcodes_url
    assert_equal 'Postcode is already whitelisted', flash[:error]
  end

  # test '#destroy - postcode is destroyed from whitelist' do
  #   assert_difference 'WhitelistedPostcode.count', -1 do
  #     post :delete, params: { postcode: 'SH241AA' }
  #   end

  #   assert_redirected_to whitelisted_postcodes_url
  # end
end