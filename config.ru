require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Run `rake db:migrate` first.'
end

use CityController
use CountryController
use UsersController
run ApplicationController
