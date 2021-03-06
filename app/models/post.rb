class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presence: { message: 'Title can not be blank' },
                    length: { maximum: 250,
                              too_long: 'Title can only accept a maximum of 250 characters' }
  validates :commentsCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'commentsCounter must be integer and >=0' }
  validates :likesCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'likesCounter must be integer and >=0' }

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
