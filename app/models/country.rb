class Country < ActiveRecord::Base
  belongs_to :user
  has_many :cities

  validates :name, :region, presence: true
end
