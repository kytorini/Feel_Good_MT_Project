class AddAdvices < ActiveRecord::Migration
  def change
    create_table :advices do |t|
      t.string :category
      t.string :content
      t.references :user
      t.timestamps
    end
  end
end
