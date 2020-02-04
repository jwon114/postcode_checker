require 'pry-rails'

class WhitelistedPostcodesController < ApplicationController
  def index
    @postcodes = WhitelistedPostcode.all
  end

  def create
    postcode = params.require(:postcode)
    postcode_validator = PostcodeValidator.new(postcode)

    if postcode_validator.whitelisted_postcode?
      flash[:error] = "Postcode '#{postcode}' is already whitelisted"
    elsif !postcode_validator.input_valid?
      flash[:error] = "'#{postcode}' is an invalid postcode"
    else
      whitelisted_postcode = WhitelistedPostcode.new
      whitelisted_postcode.postcode = postcode
      
      if whitelisted_postcode.save
        flash[:notice] = "New Postcode #{postcode} Whitelisted"
      else
        flash[:error] = "Postcode #{postcode} failed to save"
      end
    end

    redirect_to whitelisted_postcodes_url
  end

  def destroy
    whitelisted_postcode = WhitelistedPostcode.find(params[:id])
    postcode = whitelisted_postcode.postcode
    whitelisted_postcode.destroy
    
    redirect_to whitelisted_postcodes_url, notice: "Postcode #{postcode} removed"
  end
end