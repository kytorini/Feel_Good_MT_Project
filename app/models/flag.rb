class Flag < ActiveRecord::Base

  belongs_to :user
  belongs_to :advice
  validate :can_only_flag_once

  after_create :decrease_advices_health

  def can_only_flag_once
    unless Flag.where(user_id: self.user_id, advice_id: self.advice_id).empty?
      errors.add(:user_id, "can only flag once.")
    end 
  end

  def decrease_advices_health
    self.advice.health -= 1
    self.advice.save
  end



end