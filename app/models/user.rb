class User < ActiveRecord::Base
  has_many :advices
  has_many :bookmarks

  def number_of_bookmarks
      book = advices.map do 
        |advice| advice.bookmarks
      end
    book.count 
  end 

end
