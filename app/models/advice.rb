class Advice < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :content, presence: true

  def bookmarkers
    self.users
  end

  def poster
    self.user
  end

end