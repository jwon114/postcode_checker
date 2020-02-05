require "application_system_test_case"

class PostcodeCheckersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit postcode_checker_url

    assert_selector 'h1', text: 'Postcode Checker'
  end

  test 'checking whitelisted postcode' do
    visit postcode_checker_url
    fill_in 'postcode', with: 'SE17QD'
    click_on 'submit_postcode'

    assert_text "Postcode 'SE17QD' is within your service area"
  end

  test 'checking non-whitelisted postcode' do
    visit postcode_checker_url
    fill_in 'postcode', with: 'OX49 5NU'
    click_on 'submit_postcode'

    assert_text "Postcode 'OX495NU' is NOT within your service area"
  end

  test 'invalid postcode' do
    visit postcode_checker_url
    fill_in 'postcode', with: '123ABC'
    click_on 'submit_postcode'

    assert_text 'Invalid postcode'
  end
end
