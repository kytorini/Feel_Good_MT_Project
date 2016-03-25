class Advice < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :content, presence: true, length: { minimum: 5, maximum: 200 }
  after_save :health_must_be_over_minus_five

  def bookmarkers
    self.users
  end

  def poster
    self.user
  end

  def health_must_be_over_minus_five
    if health <= -5
      self.destroy
    end
  end

end