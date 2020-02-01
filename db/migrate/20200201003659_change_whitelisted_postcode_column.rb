class ChangeWhitelistedPostcodeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :whitelisted_postcodes, :postcode, :string, null: false
  end
end
