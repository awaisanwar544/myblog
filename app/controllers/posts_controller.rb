class PostsController < ApplicationController
  def index
    user_index = params['user_id'].to_i
    @user_info = User.find(user_index)
    @posts = Post.includes(:comments, comments: [:user]).where(user_id: user_index).order(id: :desc)
  end

  def show
    user_index = params['user_id'].to_i
    post_index = params['id'].to_i
    @user_info = User.find(user_index)
    @post_info = Post.find(post_index)
  end
end
