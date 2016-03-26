class User < ActiveRecord::Base
  has_many :advices
  has_many :bookmarks
  before_save :update_rank

  # def number_of_bookmarks
  #     book = advices.map do 
  #       |advice| advice.bookmarks
  #     end
  #   book.count 
  # end 

  def update_rank
  # ranks = ["Dalai Lama", "Socrates", "Deepak Chopra", "Jim Carrey", "Louis CK", "Donald Trump"]
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
