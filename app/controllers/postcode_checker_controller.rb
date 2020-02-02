class PostcodeCheckerController < ApplicationController
  def index
  end

  def check
    postcode = Postcode.new(params[:postcode])
    
    if postcode.is_valid?
      flash[:notice] = 'Postcode is whitelisted'
    else
      flash[:error] = 'Postcode is NOT whitelisted'
    end

    redirect_to postcode_checker_url
  end
end