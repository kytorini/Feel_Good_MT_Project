class Advice < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :content, presence: true, length: { minimum: 5, maximum: 200 }

  def bookmarkers
    self.users
  end

  def poster
    self.user
  end

end