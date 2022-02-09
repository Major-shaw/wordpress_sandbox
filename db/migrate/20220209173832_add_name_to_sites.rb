class AddNameToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :name, :string
    remove_column :sites, :url
  end
end
