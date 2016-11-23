class User < ActiveRecord::Base
  has_many :countries
  has_many :cities, through: :countries
  has_secure_password
end
