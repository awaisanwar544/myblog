class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def three_most_recent_posts
    # method returns the 3 most recent posts by this user
    Post.where('user_id = ?', id).order(created_at: :desc).limit(3)
  end

  def self.three_most_recent_posts(user)
    # method returns the 3 most recent posts for the given user
    Post.where('user_id = ?', user.id).order(created_at: :desc).limit(3)
  end
end
