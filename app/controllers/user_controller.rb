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
      flash[:signup_errors] = []
      if empty_name
        flash[:signup_errors] << "Please enter 'Username'"
        flash[:name_error] = "has-error"
      elsif exist_name
        flash[:signup_errors] << "This Username is already used. Please use another one"
        flash[:name_error] = "has-error"
        @exist_name = params[:username]
      end
      if empty_pass
        flash[:signup_errors] << "Please enter 'Password'"
        flash[:pass_error] = "has-error"
      end
      erb :"/users/signup"
    end
  end

end
