class AddUserToCountries < ActiveRecord::Migration[5.0]
  def change
    add_column :countries, :user_id, :integer
  end
end
