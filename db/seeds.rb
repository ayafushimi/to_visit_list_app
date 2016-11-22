User.create(username:"aaa", password:"aaa")
User.create(username:"bbb", password:"bbb")

countries_list = {
    "Algeria" => ["Africa", User.find(1)],
    "Cameroon" => ["Africa", User.find(1)],
    "Bangladesh" => ["Asia", User.find(1)],
    "Finland" => ["Europe", User.find(2)]
  }

countries_list.each do |name, arr|
  p = Country.new(name: name, region: arr[0])
  p.users << arr[1]
  p.save
  arr[1].save
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
