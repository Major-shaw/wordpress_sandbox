class AddAccountRefToSites < ActiveRecord::Migration[5.2]
  def change
    add_reference :sites, :account, foreign_key: true
  end
end
