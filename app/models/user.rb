class User < ActiveRecord::Base
  has_many :user_countries
  has_many :countries, through: :user_countries
  has_many :cities, through: :countries
  has_secure_password
end
