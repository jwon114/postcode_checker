require 'pry-rails'

class WhitelistedPostcodesController < ApplicationController
  def index
    @postcodes = WhitelistedPostcode.all
  end

  def create
    postcode = params.require(:postcode)
    new_postcode = PostcodeValidator.new(postcode)
        
    unless new_postcode.input_valid?
      flash[:error] = "Postcode #{postcode} is not a valid postcode"
    end

    if new_postcode.whitelisted_postcode?
      flash[:error] = "Postcode #{postcode} is already whitelisted"
    end

    whitelisted_postcode = WhitelistedPostcode.new
    whitelisted_postcode.postcode = postcode
    
    if whitelisted_postcode.save
      flash[:notice] = "New Postcode #{postcode} Whitelisted"
    else
      flash[:error] = "Postcode #{postcode} failed to save"
    end

    redirect_to whitelisted_postcodes_url
  end

  def destroy
  end
end