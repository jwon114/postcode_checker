require 'pry-rails'

class PostcodeCheckerController < ApplicationController
  def index
    @whitelisted_postcodes = WhitelistedPostcode.all
  end

  def check
    code = params.require(:postcode)
    postcode = PostcodeValidator.new(code)
    postcode.fetch_postcode_data

    if postcode.is_valid?
      flash[:notice] = "Postcode '#{code}' is within your service area"
    elsif postcode.response.has_key?("error")
      flash[:error] = postcode.response[:error]
    else
      flash[:error] = "Postcode '#{code}' is NOT within your service area"
    end

    redirect_to postcode_checker_url
  end
end