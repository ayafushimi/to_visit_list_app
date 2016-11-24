class CityController < ApplicationController

  get "/cities" do
    if logged_in?
      erb :"/cities/index"
    else
      redirect_to_login
    end
  end

end
