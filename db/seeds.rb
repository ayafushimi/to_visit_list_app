User.create(username:"aaa", password:"aaa")
User.create(username:"bbb", password:"bbb")

countries_list = {
    "Algeria" => {region:"Africa", user_id:1},
    "Cameroon" => {region:"Africa", user_id:1},
    "Bangladesh" => {region:"Asia", user_id:1},
    "Finland" => {region:"Europe", user_id:2}
  }

countries_list.each do |name, hash|
  p = Country.new
  p.name = name
  hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

cities_list = {
    "Algiers" => {rank:2 , country_id:1},
    "Oran" => {rank:1 , country_id:1},
    "Dhaka" => {rank:4 , country_id:3},
    "Chittagong" => {rank:3 , country_id:3},
    "Khulna" => {rank:2 , country_id:3},
    "Helsinki" => {rank:5 , country_id:4},
    "Tampere" => {rank:4 , country_id:4}
  }

cities_list.each do |name, hash|
  p = City.new
  p.name = name
  hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
