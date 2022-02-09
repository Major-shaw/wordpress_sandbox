class Addcolumntosites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :url, :string
  end
end
