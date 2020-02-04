require 'pry-rails'

class PostcodeCheckerController < ApplicationController
  def index
    @whitelisted_postcodes = WhitelistedPostcode.all
  end

  def check
    postcode = params.require(:postcode)
    postcode_validator = PostcodeValidator.new(postcode)
    postcode_validator.fetch_postcode_data

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