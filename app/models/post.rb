class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  after_save :increment_user_post_counter

  def self.update_counter_for_user(user)
    # method that updates the posts counter for the given user
    user.update(postsCounter: Post.where('user_id = ?', user.id).count)
  end

  def self.five_most_recent_comments(post)
    # method which returns the 5 most recent comments for the given post.
    Comment.where('post_id = ?', post.id).order(created_at: :desc).limit(5)
  end

  def five_most_recent_comments
    # method which returns the 5 most recent comments for this post.
    Comment.where('post_id = ?', id).order(created_at: :desc).limit(5)
  end

  private

  def increment_user_post_counter
    user.increment!(:postsCounter)
  end
end
