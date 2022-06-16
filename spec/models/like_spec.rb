require 'rails_helper'

RSpec.describe 'Like model', type: :request do
  before(:all) do
    user = User.create(name: 'Awais',
                       photo: 'url',
                       bio: 'Programmer',
                       postsCounter: 0,
                       email: 'test@test.com',
                       password: 'password')
    post = Post.create(user:, title: 'Test', text: 'This is a test', commentsCounter: 0, likesCounter: 0)
    @like = Like.create(user:, post:)
  end

  after(:all) do
    Like.destroy_all
    Post.destroy_all
    User.destroy_all
  end
  it 'Creates a valid instance' do
    expect(@like).to be_valid
  end

  it 'Update likes  counter for post' do
    post = Post.first
    Like.update_counter_for_post(post)
    expect(post.likesCounter).to be == Like.where(post:).count
  end
end
