require 'test_helper'

class RequestServiceTest < ActiveSupport::TestCase
  test '#fetch_data - successful fetch' do
    response = RequestService.fetch(postcode: 'SE17QD')

    assert response.is_a?(Hash)
    assert response['status'], 200
    assert response.has_key?('result')
  end

  test '#fetch_data - unsuccessful fetch' do
    response = RequestService.fetch(postcode: 'n')

    assert response.is_a?(Hash)
    assert response['status'], 404
    assert response.has_key?('error')
  end
end

