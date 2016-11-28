require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'visitlist secret'
    use Rack::Flash
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_to_login
      redirect "/login"
    end
  end

  get "/" do
    if logged_in?
      redirect "/user"
    else
      erb :index
    end
  end

end
