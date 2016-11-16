class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.text :name
      t.integer :rank
    end
  end
end
