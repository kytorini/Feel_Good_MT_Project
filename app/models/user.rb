class User < ActiveRecord::Base

  has_many :advices
  has_many :bookmarks

  # def retrieve_bookmarks_content
  #   ids = self.bookmarks.plus(:advice_id)
  #   Advice.find(ids).pluck(:content)
  # end

end