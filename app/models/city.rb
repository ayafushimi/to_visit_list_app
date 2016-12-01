class City < ActiveRecord::Base
  belongs_to :country

  validates :name, :rank, presence: true
end
