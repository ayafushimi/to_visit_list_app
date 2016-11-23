class Country < ActiveRecord::Base
  belongs_to :user
  has_many :cities
end
