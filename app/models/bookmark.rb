class Bookmark < ActiveRecord::Base

  belongs_to :user
  belongs_to :advice

  validate :can_only_bookmark_once

  after_create :increase_advices_health
  after_create :increase_users_points

  def can_only_bookmark_once
    unless Bookmark.where(user_id: self.user_id, advice_id: self.advice_id).empty?
      errors.add(:user_id, "can only bookmark once.")
    end 
  end

  def increase_advices_health
    self.advice.health += 1
    self.advice.save
  end

  def increase_users_points

    @advice = Advice.find(self.advice_id)
    @user_id = @advice.user_id
    @user = User.find(@user_id)
    if @user
      @user.points += 1
      @user.save
    end
  end
  
end