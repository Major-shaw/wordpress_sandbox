class CreateContainerServers < ActiveRecord::Migration[5.2]
  def change
    create_table :container_servers do |t|

      t.timestamps
    end
  end
end
