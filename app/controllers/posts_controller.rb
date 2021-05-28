class PostsController < ApplicationController
  before_action :set_post, only:[:edit, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only:[:create]

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Successfully posted"
    else
      flash[:error] = "Failed to post"
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
    if current_user.id != @post.user_id
      flash[:error] = "You can only edit your own posts"
      redirect_to feed_path
    end

  end


  def update
    if current_user.id != @post.user_id
      flash[:error] = "You can only edit your own posts"
      redirect_to root_path
    else
      @post.body = params[:post][:body]
      if @post.save
        flash[:success] = "Post successfully edited"
      else
        flash[:error] = "Failed to edit post"
      end
    end
    redirect_to feed_path
  end

  def destroy
    if current_user.id != @post.user_id
      flash[:error] = "You can only delete your own posts"
      redirect_back(fallback_location: root_path)
    else
      if @post.delete
        flash[:success] = "Post successfully delete"
      else
        flash[:error] = "Failed to delete post"
      end
      redirect_to feed_path
    end
  end

  def index
    
    temp = []
    friend_list.each do |f|
      if f.user_id != current_user.id
        temp.push(f.user_id)
      end
      if f.f_id != current_user.id
        temp.push(f.f_id)
      end
    end
    temp.push(current_user.id)
    @posts = Post.where(user_id: temp).order("id desc")
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:user_id,:body)
  end

  def require_same_user
    if current_user.id != params[:post][:user_id].to_i
      flash[:alert] = "You can only update/delete your own profile"
      redirect_to root_path
    end
  end


end