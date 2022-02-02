class AddColumnsToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :php_version, :string
    add_column :sites, :wp_version, :string
    add_column :sites, :admin_username, :string
    add_column :sites, :admin_password, :string
    add_column :sites, :status, :string, default: "running"
    add_column :sites, :url, :string

  end
end
