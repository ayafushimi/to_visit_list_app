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

  post "/countries/create" do
    empty_country_name = params[:country][:name].empty?
    empty_region = params[:country][:region].empty?
    exist_country = !!Country.all.detect{|x| x.name == params[:country][:name]}
    exist_city = !params[:city][:name].empty? && !!City.all.detect{|x| x.name == params[:city][:name]}
    empty_rank = !params[:city][:name].empty? && params[:city][:rank].empty?

    if !(empty_country_name||empty_region||exist_country||empty_rank)
      country = Country.create(params[:country])
      country.user = current_user
      # if !params[:city][:name].empty?
      #   city = City.find_or_create(params[:city])
      #   city.country = country
      # end

    end
  end

end
