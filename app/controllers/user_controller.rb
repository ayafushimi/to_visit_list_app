class UsersController < ApplicationController

  get "/user" do
    if logged_in?
      erb :"/users/index"
    else
      redirect_to_login
    end
  end

  get "/login" do
    erb :"/users/login"
  end

  get "/signup" do
    erb :"/users/signup"
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
      @signup_errors = []
      if empty_name
        @signup_errors << "Please enter 'username'"
      elsif exist_name
        @signup_errors << "That username is already used. Please use another username"
      end
      if empty_pass
        @signup_errors << "Please enter 'password'"
      end
    end
  end

end
