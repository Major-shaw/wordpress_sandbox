class AddColumnsToDbServers < ActiveRecord::Migration[5.2]
  def change
    add_column :db_servers, :ip, :string
  end
end
