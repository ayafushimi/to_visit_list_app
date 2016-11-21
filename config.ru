require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Run `rake db:migrate` first.'
end

use UsersController
run ApplicationController
