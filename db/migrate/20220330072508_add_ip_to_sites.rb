class AddIpToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :client_ip, :string
  end
end
