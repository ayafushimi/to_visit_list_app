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

  post "/login" do
    empty_name = params[:username].empty?
    empty_pass = params[:password].empty?
    exist_name = User.all.detect{|x| x.username = params[:username]}

    if !(empty_name||empty_pass||exist_name)
      user = User.create(username: params[:username], password: params[:password])
    else
      
    end
  end

end
