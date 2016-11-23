class CountryController < ApplicationController

  get "/countries" do
    if logged_in?
      erb :"/countries/index"
    else
      redirect_to_login
    end
  end

end
