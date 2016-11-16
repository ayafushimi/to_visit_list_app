class AddCountryToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :country_id, :integer
  end
end
