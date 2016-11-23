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
    exist_country = Country.all.detect{|x| x.name == params[:country][:name]}
    exist_city = !params[:city][:name].empty? && !!City.all.detect{|x| x.name == params[:city][:name]}
    empty_rank = !params[:city][:name].empty? && params[:city][:rank].empty?

    if !(empty_country_name||empty_region||exist_country||exist_city||empty_rank)
      country = Country.create(params[:country])
      country.user = current_user
      country.save
      if !params[:city][:name].empty?
        city = City.create(params[:city])
        city.country = country
        city.save
      end
      redirect "/countries/#{country.id}"
    else
      flash.now[:create_errors] = []
      if empty_country_name
        flash.now[:create_errors] << "Please enter 'Country Name'"
      elsif exist_country
        flash.now[:create_errors] << "This Country already exists. Please check <a href='/countries/#{exist_country.id}' class='alert-link'>this page</a>"
      elsif exist_city
        flash.now[:create_errors] << "This City already exists. Please check <a href='/countries/#{City.all.detect{|x| x.name == params[:city][:name]}.id}' class='alert-link'>this page</a>"
      end
      if empty_region
        flash.now[:create_errors] << "Please select 'Region'"
      end
      if empty_rank
        flash.now[:create_errors] << "Please select 'Rank' of city"
      end
      erb :"/countries/create"
    end
  end

end
