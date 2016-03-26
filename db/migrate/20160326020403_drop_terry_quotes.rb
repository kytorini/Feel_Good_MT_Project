class DropTerryQuotes < ActiveRecord::Migration
  def change
    drop_table :terry_quotes
  end
end
