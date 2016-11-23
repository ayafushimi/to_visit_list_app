class CountryController < ApplicationController

  get "/countries" do
    if logged_in?
      erb :"/countries/index"
    else
      redirect_to_login
    end
  end

  get "/countries/create" do
    if logged_in?
      erb :"/countries/create"
    else
      redirect_to_login
    end
  end

  get "/countries/:id" do
    if logged_in?
      @country = Country.find(params[:id])
      erb :"/countries/show"
    else
      redirect_to_login
    end
  end

end
