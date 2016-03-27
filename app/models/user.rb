class User < ActiveRecord::Base
  has_many :advices, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :username, uniqueness: true

  before_save :update_rank

  def update_rank
    if points > 100
      self.rank = "Dalai Lama"
    elsif points > 80
      self.rank = "Socrates"
    elsif points > 60
      self.rank = "Deepak Chopra"
    elsif points > 40
      self.rank = "Jim Carrey"
    elsif points > 20
      self.rank = "Louis CK"
    elsif points < 20
      self.rank = "Donald Trump"
    end 
  end

end
