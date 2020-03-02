require 'test_helper'

class InputValidatorTest < ActiveSupport::TestCase
  test '#input_valid? - valid postcode input' do
    is_valid = InputValidator.validate(input: 'SE17QD')

    assert is_valid
  end

  test '#input_valid? - valid postcode input with spaces and lowercase' do
    is_valid = InputValidator.validate(input: ' se 17 QD')

    assert is_valid
  end

  test '#input_valid? - invalid postcode input' do
    is_valid = InputValidator.validate(input: '!" #$ %^')

    assert_not is_valid
  end
end