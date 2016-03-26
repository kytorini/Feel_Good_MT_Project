class AddTerryQuotes < ActiveRecord::Migration
  def change
    create_table :terry_quotes do |t|
      t.string :quote
      t.timestamps
    end
  end
end
