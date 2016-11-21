require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'.to_sym
    enable :sessions
    set :session_secret, 'visitlist secret'
  end

end
