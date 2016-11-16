class Country < ActiveRecord::Base
  has_many :user_countries
  has_many :users, through: :user_countries
  has_many :cities
end
