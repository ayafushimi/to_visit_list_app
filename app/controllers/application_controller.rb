require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'.to_sym
    enable :sessions
    set :session_secret, 'visitlist secret'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
