class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  has_many :likes

  validates :name, presence: { message: 'Name can not be blank' }
  validates :postsCounter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
                            message: 'postsCounter must be integer and >=0' }

  after_initialize :set_defaults

  def three_most_recent_posts
    # method returns the 3 most recent posts by this user
    Post.where('user_id = ?', id).order(created_at: :desc).limit(3)
  end

  def self.three_most_recent_posts(user)
    # method returns the 3 most recent posts for the given user
    Post.where('user_id = ?', user.id).order(created_at: :desc).limit(3)
  end

  private

  def set_defaults
    self.postsCounter ||= 0
  end
end
