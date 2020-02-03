class PostcodeCheckerController < ApplicationController
  def index
    @whitelisted_postcodes = WhitelistedPostcode.all
  end

  def check
    code = params.require(:postcode)
    postcode = PostcodeValidator.new(code)
    
    if postcode.is_valid?
      flash[:notice] = "Postcode '#{code}' is whitelisted"
    else
      flash[:error] = "Postcode '#{code}' is NOT whitelisted"
    end

    redirect_to postcode_checker_url
  end
end