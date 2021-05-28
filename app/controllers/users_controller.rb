class UsersController < ApplicationController
  before_action :set_user , only: [:show]
  before_action :set_user_edit, only: [:edit]
  before_action :set_user_update, only: [:update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]



  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:group_message_id] = 1
      Message.create(user_id: @user.id, group_message_id: 1,
         body: @user.username + ' just joined the app', initiate: true)
      redirect_to root_path
      flash[:success] = "Signed up & logged in"

    else
      flash[:error] = "Failed to create new user"
      redirect_to login_path
    end
  
    
  end

  def index
    if !logged_in? || current_user.id != 1
      redirect_to root_path
    else
      @users = User.all
    end  

  end

  def show
    if !logged_in?
      redirect_to login_path
    end

    @posts = Post.where(user_id: @user.id).order("id desc")
  end

  def edit
    
  end

  def update

    if @user.update(user_params)
      flash[:success] = "Profile successfully updated"
      render 'edit'

    else
      flash[:error] = "Failed to update profile"
      render 'edit'
    end

  end
    
  def destroy
    user = User.find(current_user.id)
    if user.delete
      session[:user_id] = nil
      session[:group_message_id] = nil
      flash[:success] = "Account successfully deleted"
      redirect_to login_path
    else
      flash[:error] = "Failed to delete account"
      redirect_back(fallback_location: root_path)
    end

  end


  private

  def user_params
    params.require(:user).permit(:username,:password, :email,:about)
  end

  def set_user
    temp = User.where('lower(username) = ?',params[:username])
    temp.each do |t|
      @user = t
    end
  end

  def set_user_update

    @user = User.find(params[:id])
  end

  def set_user_edit
    @user = User.find_by_username(params[:id])
  
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You can only update/delete your own profile"
      redirect_to root_path
    end
  end

end

