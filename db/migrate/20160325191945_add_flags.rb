class AddFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :user
      t.references :advice    
      t.timestamps
    end
  end
end
