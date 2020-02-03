require 'pry-rails'

class WhitelistedPostcodeController < ApplicationController
  def index
    @postcodes = WhitelistedPostcode.all
  end

  def create
    binding.pry
    postcode = params.require(:postcode)
    new_postcode = WhitelistedPostcode.new(postcode)
    
    # unless new_postcode.valid?
    #   flash[:error] = "Postcode #{postcode} is not a valid postcode"
    #   redirect_to whitelisted_postcode_url
    # end
    
    if new_postcode.save
      flash[:notice] = "New Postcode #{postcode} Whitelisted"
    else
      flash[:error] = "Postcode #{postcode} failed to save"
    end

    redirect_to whitelisted_postcode_url
  end

  def destroy
  end
end