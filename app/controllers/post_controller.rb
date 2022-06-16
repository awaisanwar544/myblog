class PostController < ApplicationController
  def new
    @post = Post.new
    @errors = []
  end

  def create
    title = params[:post][:title]
    text = params[:post][:text]
    @post = Post.new(post_params)
    @post.user = current_user
    @post.likesCounter = 0
    @post.commentsCounter = 0
    @errors = []
    @errors.push 'Title can not be empty' if title == ''
    @errors.push 'Text can not be empty' if text == ''
    if @errors.empty?
      if @post.save
        redirect_to user_path(id: @post.user.id), notice: 'Post created sucessfully'
      else
        render :new, status: 400
      end
    else
      render :new, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
