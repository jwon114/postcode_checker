require 'test_helper'

class WhitelistedPostcodesControllerTest < ActionDispatch::IntegrationTest
  test '#index - list all postcodes and options to add/remove' do
    get whitelisted_postcodes_url

    assert_response :success
    assert_equal WhitelistedPostcode.all, assigns(:postcodes)
  end

  test '#create - postcode is created on whitelist' do
    assert_difference 'WhitelistedPostcode.count' do
      post whitelisted_postcodes_url, params: { postcode: 'EC1A' }
    end
    
    assert_redirected_to whitelisted_postcodes_url
    assert_equal "New Postcode 'EC1A' Whitelisted", flash[:notice]
  end

  test '#create - postcode already exists on whitelist' do
    assert_no_difference 'WhitelistedPostcode.count' do
      post whitelisted_postcodes_url, params: { postcode: 'SH241AA' }
    end

    assert_redirected_to whitelisted_postcodes_url
    assert_equal "Postcode 'SH241AA' is already whitelisted", flash[:error]
  end

  test '#create - postcode is invalid input' do
    assert_no_difference 'WhitelistedPostcode.count' do
      post whitelisted_postcodes_url, params: { postcode: '1;$%@^' }
    end

    assert_redirected_to whitelisted_postcodes_url
    assert_equal "'1;$%@^' is not a valid postcode", flash[:error]
  end

  test '#destroy - postcode is destroyed from whitelist' do
    postcode = whitelisted_postcodes(:one)
    assert_difference 'WhitelistedPostcode.count', -1 do
      delete whitelisted_postcode_url(postcode), params: { postcode: 'SH241AA' }
    end

    assert_redirected_to whitelisted_postcodes_url
    assert_equal "Postcode 'SH241AA' removed", flash[:notice]
  end
end