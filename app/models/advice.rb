class Advice < ActiveRecord::Base

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  validates :content, uniqueness: true, length: { minimum: 5, maximum: 200 }
  
  after_save :health_must_be_over_minus_five
  after_create :update_users_points

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

  def update_users_points
    self.user.points += 1
    self.user.save
  end

end