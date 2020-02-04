class PostcodeCheckerController < ApplicationController
  def index
    @whitelisted_postcodes = WhitelistedPostcode.all
  end

  def check
    code = params.require(:postcode)
    postcode = PostcodeValidator.new(code)
    
    if postcode.is_valid?
      flash[:notice] = "Postcode '#{code}' is within your service area"
    else
      flash[:error] = "Postcode '#{code}' is NOT within your service area"
    end

    redirect_to postcode_checker_url
  end
end