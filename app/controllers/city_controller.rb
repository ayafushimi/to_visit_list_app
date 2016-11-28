class CityController < ApplicationController

  get "/cities" do
    if logged_in?
      @cities_page = "active"
      erb :"/cities/index"
    else
      redirect_to_login
    end
  end

  get "/cities/create" do
    if logged_in?
      @country_name_disabled = "disabled"
      @country_region_disabled = "disabled"
      erb :"/cities/create"
    else
      redirect_to_login
    end
  end

  get "/cities/:id" do
    if logged_in?
      @city = City.find(params[:id])
      erb :"/cities/show"
    else
      redirect_to_login
    end
  end

  get "/cities/:id/edit" do
    if logged_in?
      @city = City.find(params[:id])
      @name_input = @city.name
      case @city.rank
      when 5
        @rank5 = "selected"
      when 4
        @rank4 = "selected"
      when 3
        @rank3 = "selected"
      when 2
        @rank2 = "selected"
      when 1
        @rank1 = "selected"
      end
      val = "@country_#{@city.country.id}"
      value = "selected"
      eval("#{val} = value")
      @country_name_disabled = "disabled"
      @country_region_disabled = "disabled"
      erb :"/cities/edit"
    else
      redirect_to_login
    end
  end

  get "/cities/:id/delete" do
    if logged_in?
      City.find(params[:id]).delete
      redirect "/cities"
    else
      redirect_to_login
    end
  end

  post "/cities/create" do
    empty_name = params[:name].empty?
    exist_city = current_user.cities.detect{|x| x.name == params[:name]}
    empty_rank = params[:rank].empty?
    empty_country = params[:country_id].empty?
    create_country = (params[:country_id] == "create_country")
    if create_country
      empty_country_name = params[:country][:name].empty?
      exist_country = current_user.countries.detect{|x| x.name == params[:country][:name]}
      empty_region =  params[:country][:region].empty?
    end

    if !(empty_name||exist_city||empty_rank||empty_country||empty_country_name||exist_country||empty_region)
      city = City.create(name:params[:name], rank:params[:rank])
      if !create_country
        city.update(country_id:params[:country_id])
      else
        country = Country.create(params[:country])
        country.update(user_id:current_user.id)
        city.update(country_id:country.id)
      end
      redirect "/cities/#{city.id}"
    else
      flash.now[:create_errors] = []
      if empty_name
        flash.now[:create_errors] << "Please enter 'City Name'"
        flash.now[:name_error] = "has-error"
      elsif exist_city
        flash.now[:create_errors] << "This City already exists. Please check <a href='/cities/#{exist_city.id}' class='alert-link'>this page</a>"
        flash.now[:name_error] = "has-error"
      end
      if empty_rank
        flash.now[:create_errors] << "Please select 'Rank'"
        flash.now[:rank_error] = "has-error"
      end
      if empty_country
        flash.now[:create_errors] << "Please select 'Country'"
        flash.now[:country_error] = "has-error"
      end

      @name_input = params[:name]
      case params[:rank]
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
      current_user.countries.each do |country|
        if country.id == params[:country_id].to_i
          var = "@country_#{country.id}"
          value = "selected"
          eval("#{var} = value")
        end
      end
      @country_name_disabled = "disabled"
      @country_region_disabled = "disabled"

      if create_country
        if empty_country_name
          flash.now[:create_errors] << "Please enter 'Country Name'"
          flash.now[:country_name_error] = "has-error"
        elsif exist_country
          flash.now[:create_errors] << "This Country already exists. Please select from the avobe list"
          flash.now[:country_name_error] = "has-error"
        end
        if empty_region
          flash.now[:create_errors] << "Please select 'Region'"
          flash.now[:country_region_error] = "has-error"
        end
        @create_country = "selected"
        @country_name_disabled = ""
        @country_region_disabled = ""
        @country_name_input = params[:country][:name]
        REGIONS.each do |region|
          if params[:country][:region] == region
            var = "@region_#{region}"
            value = "selected"
            eval("#{var} = value")
          end
        end
      end
      erb :"/cities/create"
    end
  end

  post "/cities/:id/edit" do
    @city = City.find(params[:id])

    empty_name = params[:name].empty?
    exist_city = City.all.detect{|x| x.name == params[:name]}
    empty_rank = params[:rank].empty?
    empty_country = params[:country_id].empty?
    create_country = (params[:country_id] == "create_country")
    if create_country
      empty_country_name = params[:country][:name].empty?
      exist_country = Country.all.detect{|x| x.name == params[:country][:name]}
      empty_region =  params[:country][:region].empty?
    end

    if !(empty_name||exist_city||empty_rank||empty_country||empty_country_name||exist_country||empty_region)
      @city.update(name:params[:name], rank:params[:rank])
      if !create_country
        @city.update(country_id:params[:country_id])
      else
        country = Country.create(params[:country])
        country.update(user_id:current_user.id)
        @city.update(country_id:country.id)
      end
      redirect "/cities/#{@city.id}"
    else
      flash.now[:edit_errors] = []
      if empty_name
        flash.now[:edit_errors] << "Please enter 'City Name'"
        flash.now[:name_error] = "has-error"
      elsif exist_city
        flash.now[:edit_errors] << "This City already exists. Please check <a href='/cities/#{exist_city.id}' class='alert-link'>this page</a>"
        flash.now[:name_error] = "has-error"
      end
      if empty_rank
        flash.now[:edit_errors] << "Please select 'Rank'"
        flash.now[:rank_error] = "has-error"
      end
      if empty_country
        flash.now[:edit_errors] << "Please select 'Country'"
        flash.now[:country_error] = "has-error"
      end

      @name_input = params[:name]
      case params[:rank]
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
      current_user.countries.each do |country|
        if country.id == params[:country_id].to_i
          var = "@country_#{country.id}"
          value = "selected"
          eval("#{var} = value")
        end
      end
      @country_name_disabled = "disabled"
      @country_region_disabled = "disabled"

      if create_country
        if empty_country_name
          flash.now[:create_errors] << "Please enter 'Country Name'"
          flash.now[:country_name_error] = "has-error"
        elsif exist_country
          flash.now[:create_errors] << "This Country already exists. Please select from the avobe list"
          flash.now[:country_name_error] = "has-error"
        end
        if empty_region
          flash.now[:create_errors] << "Please select 'Region'"
          flash.now[:country_region_error] = "has-error"
        end
        @create_country = "selected"
        @country_name_disabled = ""
        @country_region_disabled = ""
        @country_name_input = params[:country][:name]
        REGIONS.each do |region|
          if params[:country][:region] == region
            var = "@region_#{region}"
            value = "selected"
            eval("#{var} = value")
          end
        end
      end
      erb :"/cities/edit"
    end
  end

end
