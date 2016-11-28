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

  get "/countries/:id/edit" do
    if logged_in?
      @country = Country.find(params[:id])
      @country_name_input = @country.name
      case @country.region
      when "Africa"
        @region_africa = "selected"
      when "Americas"
        @region_america = "selected"
      when "Asia"
        @region_asia = "selected"
      when "Europe"
        @region_europe = "selected"
      when "Oceania"
        @region_oceania = "selected"
      end
      erb :"/countries/edit"
    else
      redirect_to_login
    end
  end

  get "/countries/:id/delete" do
    if logged_in?
      country=Country.find(params[:id])
      country.cities.each do |city|
        city.delete
      end
      country.delete
      redirect "/countries"
    else
      redirect_to_login
    end
  end

  post "/countries/create" do
    empty_country_name = params[:country][:name].empty?
    empty_region = params[:country][:region].empty?
    exist_country = current_user.countries.detect{|x| x.name == params[:country][:name]}
    exist_city = !params[:city][:name].empty? && !!current_user.cities.detect{|x| x.name == params[:city][:name]}
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
        flash.now[:country_name_error] = "has-error"
      elsif exist_country
        flash.now[:create_errors] << "This Country already exists. Please check <a href='/countries/#{exist_country.id}' class='alert-link'>this page</a>"
        flash.now[:country_name_error] = "has-error"
      elsif exist_city
        flash.now[:create_errors] << "This City already exists. Please check <a href='/countries/#{City.all.detect{|x| x.name == params[:city][:name]}.id}' class='alert-link'>this page</a>"
        flash.now[:city_name_error] = "has-error"
      end
      if empty_region
        flash.now[:create_errors] << "Please select 'Region'"
        flash.now[:country_region_error] = "has-error"
      end
      if empty_rank
        flash.now[:create_errors] << "Please select 'Rank' of city"
        flash.now[:city_rank_error] = "has-error"
      end
      @country_name_input = params[:country][:name]
      case params[:country][:region]
      when "Africa"
        @region_africa = "selected"
      when "Americas"
        @region_america = "selected"
      when "Asia"
        @region_asia = "selected"
      when "Europe"
        @region_europe = "selected"
      when "Oceania"
        @region_oceania = "selected"
      end
      @city_name_input = params[:city][:name]
      case params[:city][:rank]
      when "5"
        @rank5 = "selected"
      when "4"
        @rank4 = "selected"
      when "3"
        @rank3 = "selected"
      when "2"
        @rank2 = "selected"
      when "1"
        @rank1 = "selected"
      end
      erb :"/countries/create"
    end
  end

  post "/countries/:id/edit" do
    @country = Country.find(params[:id])
    empty_country_name = params[:country][:name].empty?
    empty_region = params[:country][:region].empty?
    exist_country = Country.all.detect{|x| x.name == params[:country][:name]} && params[:country][:name] != @country.name

    if !(empty_country_name||empty_region||exist_country)
      @country.update(params[:country])
      redirect "/countries/#{@country.id}"
    else
      flash.now[:edit_errors] = []
      if empty_country_name
        flash.now[:edit_errors] << "Please enter 'Country Name'"
        flash.now[:country_name_error] = "has-error"
      elsif exist_country
        flash.now[:edit_errors] << "This Country already exists. Please check <a href='/countries/#{exist_country.id}' class='alert-link'>this page</a>"
        flash.now[:country_name_error] = "has-error"
      end
      if empty_region
        flash.now[:edit_errors] << "Please select 'Region'"
        flash.now[:country_region_error] = "has-error"
      end
      @country_name_input = params[:country][:name]
      case params[:country][:region]
      when "Africa"
        @region_africa = "selected"
      when "Americas"
        @region_america = "selected"
      when "Asia"
        @region_asia = "selected"
      when "Europe"
        @region_europe = "selected"
      when "Oceania"
        @region_oceania = "selected"
      end
      erb :"/countries/edit"
    end
  end

end
