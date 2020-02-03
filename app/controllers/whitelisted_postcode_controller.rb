require 'pry-rails'

class WhitelistedPostcodeController < ApplicationController
  def index
    @postcodes = WhitelistedPostcode.all
  end

  # def create
  #   binding.pry
  #   postcode = params.require(:postcode)
  #   new_postcode = Postcode.new(postcode)
        
  #   unless new_postcode.input_valid?
  #     flash[:error] = "Postcode #{postcode} is not a valid postcode"
  #     redirect_to whitelisted_postcode_url
  #   end

  #   new_whitelisted_postcode = WhitelistedPostcode.new
  #   new_whitelisted_postcode.postcode = postcode
    
  #   if new_whitelisted_postcode.save
  #     flash[:notice] = "New Postcode #{postcode} Whitelisted"
  #   else
  #     flash[:error] = "Postcode #{postcode} failed to save"
  #   end

  #   redirect_to whitelisted_postcode_url
  # end

  def destroy
  end
end