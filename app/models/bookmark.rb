class Bookmark < ActiveRecord::Base

  belongs_to :user
  belongs_to :advice

  after_create :add_bookmark_to_user

  def add_bookmark_to_user
    user.bookmarks << self.advice_id
    user.save
  end


end