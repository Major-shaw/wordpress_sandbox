class AddDbDetailsToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :db_username, :string
    add_column :sites, :db_password, :string
  end
end
