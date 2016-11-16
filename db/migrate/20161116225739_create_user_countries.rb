class CreateUserCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :user_countries do |t|
      t.integer :user_id
      t.integer :country_id
    end
  end
end
