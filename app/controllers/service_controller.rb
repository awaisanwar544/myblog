class ServiceController < ApplicationController
  def like
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    Like.create(user:, post:)
    redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
  end

  def comment
    post = Post.find(params[:post_id])
    text = params[:text]
    if text == ''
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
      return
    end
    Comment.create(user: current_user, post:, text:)
    respond_to do |format|
      format.html do
        redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
      end
    end
  end
end
