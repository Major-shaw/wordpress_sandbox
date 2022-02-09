class Removecolumntosites < ActiveRecord::Migration[5.2]
  def change
    remove_column :sites, :url
  end
end
