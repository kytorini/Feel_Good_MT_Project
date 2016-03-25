class Bookmark < ActiveRecord::Base

  belongs_to :user
  belongs_to :advice
  validate :can_only_bookmark_once

  default_scope {order('created_at DESC')}

  def can_only_bookmark_once
    unless Bookmark.where(user_id: self.user_id, advice_id: self.advice_id).empty?
      errors.add(:user_id, "can only bookmark once.")
    end 
  end
  
end