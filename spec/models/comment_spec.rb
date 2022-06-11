require 'rails_helper'

RSpec.describe 'Comment model', type: :request do
  it 'Creates a valid instance' do
    post = Post.first
    user = User.second
    comment = Comment.new(user:, post:, text: 'Great post')
    expect(comment).to be_valid
  end

  it 'Update comments counter for post' do
    post = Post.first
    Comment.update_counter_for_post(post)
    expect(post.commentsCounter).to be == Comment.where(post:).count
  end
end
