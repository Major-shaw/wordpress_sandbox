class AddColumnsToContainerServers < ActiveRecord::Migration[5.2]
  def change
    add_column :container_servers, :ip, :string
  end
end
