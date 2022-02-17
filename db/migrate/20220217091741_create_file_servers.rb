class CreateFileServers < ActiveRecord::Migration[5.2]
  def change
    create_table :file_servers do |t|

      t.timestamps
    end
  end
end
