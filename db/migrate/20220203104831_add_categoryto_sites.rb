class AddCategorytoSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :category, :string
  end
end
