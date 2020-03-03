class PostcodeCheckerController < ApplicationController
  def index
    @whitelisted_postcodes = WhitelistedPostcode.all
  end

  def check
    postcode = params.require(:postcode)
    valid_postcode = PostcodeValidator.is_valid?(postcode: postcode)

    if postcode_validator.is_valid?
      flash[:notice] = "Postcode '#{postcode_validator.postcode}' is within your service area"
    elsif postcode_validator.response.has_key?("error")
      flash[:error] = postcode_validator.response[:error]
    else
      flash[:error] = "Postcode '#{postcode_validator.postcode}' is NOT within your service area"
    end

    redirect_to postcode_checker_url
  end
end