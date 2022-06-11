require 'rails_helper'

RSpec.describe 'Like model', type: :request do
  it 'Creates a valid instance' do
    post = Post.first
    user = User.second
    like = Like.new(user:, post:)
    expect(like).to be_valid
  end

  it 'Update likes  counter for post' do
    post = Post.first
    Like.update_counter_for_post(post)
    expect(post.likesCounter).to be == Like.where(post:).count
  end
end
