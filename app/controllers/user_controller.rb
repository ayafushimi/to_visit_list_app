class UsersController < ApplicationController

  get "/user" do
    if logged_in?
      erb :"/users/index"
    else
      redirect_to_login
    end
  end

  get "/signup" do
    erb :"/users/signup"
  end

  get "/login" do
    erb :"/users/login"
  end

  post "/signup" do
    empty_name = params[:username].empty?
    empty_pass = params[:password].empty?
    exist_name = !!User.all.detect{|x| x.username == params[:username]}

    if !(empty_name||empty_pass||exist_name)
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect "/user"
    else
      flash.now[:signup_errors] = []
      if empty_name
        flash.now[:signup_errors] << "Please enter 'Username'"
        flash.now[:name_error] = "has-error"
      elsif exist_name
        flash.now[:signup_errors] << "This Username is already used. Please use another one"
        flash.now[:name_error] = "has-error"
      end
      if empty_pass
        flash.now[:signup_errors] << "Please enter 'Password'"
        flash.now[:pass_error] = "has-error"
      end
      @exist_name = params[:username]
      erb :"/users/signup"
    end
  end

  post "/login" do
    empty_name = params[:username].empty?
    empty_pass = params[:password].empty?
    invalid_name = !User.all.detect{|x| x.username == params[:username]}

    if !(empty_name||empty_pass||invalid_name)
      user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
      if user
        session[:user_id] = user.id
        redirect "/user"
      else
        flash.now[:login_errors] = ["Incorrect Password"]
        flash.now[:pass_error] = "has-error"
        @input = params[:username]
        erb :"/users/login"
      end
    else
      flash.now[:login_errors] = []
      if empty_name
        flash.now[:login_errors] << "Please enter 'Username'"
        flash.now[:name_error] = "has-error"
      elsif invalid_name
        flash.now[:login_errors] << "Incorrect Username"
        flash.now[:name_error] = "has-error"
      end
      if empty_pass
        flash.now[:login_errors] << "Please enter 'Password'"
        flash.now[:pass_error] = "has-error"
      end
      @input = params[:username]
      erb :"/users/login"
    end
  end

end
