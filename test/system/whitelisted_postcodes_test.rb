require "application_system_test_case"

class WhitelistedPostcodesTest < ApplicationSystemTestCase
  test 'visit the whitelisted postcodes page' do
    visit whitelisted_postcodes_url

    assert_selector 'h1', text: 'Whitelisted Postcodes'
  end

  test 'adding postcode to whitelist' do
    visit whitelisted_postcodes_url
    fill_in 'postcode', with: 'OX49 5NU'
    click_on 'add_postcode'

    assert_text "New Postcode 'OX495NU' Whitelisted"
  end

  test 'attempt to add postcode that is already whitelisted' do
    visit whitelisted_postcodes_url
    fill_in 'postcode', with: 'sh24 1ab'
    click_on 'add_postcode'

    assert_text "Postcode 'SH241AB' is already whitelisted"
  end

  test 'deleting postcode from whitelist' do
    visit whitelisted_postcodes_url
    whitelisted_postcodes = page.all(:css, 'table tbody tr')
    postcode = whitelisted_postcodes.first.find(:css, 'td:first-child').text
    first('table tbody tr').click_link('Delete')
    new_whitelisted_postcodes = page.all(:css, 'table tbody tr')
    
    assert_text "Postcode '#{postcode}' removed"
    assert_css 'table tbody tr', count: 1
  end
  
end
