require 'rails_helper'

RSpec.describe 'Comment model', type: :request do
  before(:all) do
    user = User.create(name: 'Awais',
                       photo: 'url',
                       bio: 'Programmer',
                       postsCounter: 0,
                       email: 'test@test.com',
                       password: 'password')
    post = Post.create(user:, title: 'Test', text: 'This is a test', commentsCounter: 0, likesCounter: 0)
    @comment = Comment.create(user:, post:, text: 'Great post')
  end

  after(:all) do
    Comment.destroy_all
    Post.destroy_all
    User.destroy_all
  end
  it 'Creates a valid instance' do
    expect(@comment).to be_valid
  end

  it 'Update comments counter for post' do
    post = Post.first
    Comment.update_counter_for_post(Post.first)
    expect(post.commentsCounter).to be == Comment.where(post:).count
  end
end
