require 'pry-rails'

class WhitelistedPostcodesController < ApplicationController
  def index
    @postcodes = WhitelistedPostcode.all
  end

  def create
    postcode = params.require(:postcode)
    postcode_validator = PostcodeValidator.new(postcode)

    if postcode_validator.whitelisted_postcode?
      flash[:error] = "Postcode '#{postcode_validator.postcode}' is already whitelisted"
    elsif !postcode_validator.input_valid?
      flash[:error] = "'#{postcode_validator.postcode}' is not a valid postcode"
    else
      whitelisted_postcode = WhitelistedPostcode.new
      whitelisted_postcode.postcode = postcode
      
      if whitelisted_postcode.save
        flash[:notice] = "New Postcode '#{whitelisted_postcode.postcode}' Whitelisted"
      else
        flash[:error] = "Postcode '#{whitelisted_postcode.postcode}' failed to save"
      end
    end

    redirect_to whitelisted_postcodes_url
  end

  def destroy
    whitelisted_postcode = WhitelistedPostcode.find(params[:id])
    postcode = whitelisted_postcode.postcode
    whitelisted_postcode.destroy
    
    redirect_to whitelisted_postcodes_url, notice: "Postcode '#{postcode}' removed"
  end
end