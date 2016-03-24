class User < ActiveRecord::Base

  has_many :advices
  has_many :bookmarks

  @bookmarks = []
  
end