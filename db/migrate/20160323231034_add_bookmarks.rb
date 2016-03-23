class AddBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user
      t.references :advice    
      t.timestamps
    end
  end
end
