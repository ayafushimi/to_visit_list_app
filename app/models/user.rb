class User < ActiveRecord::Base
  has_many :countries
  has_secure_password

  def cities
    cities = []
    self.countries.each do |country|
      country.cities do |city|
        cities << city
      end
    end
    cities
  end

end
