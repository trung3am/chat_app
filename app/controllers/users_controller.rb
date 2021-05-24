class UsersController < ApplicationController
  before_action :set_user , except: [:create, :index, :show]  



  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:group_message_id] = 1
      Message.create(user_id: 1, group_message_id: 1,
         body: "Welcome new user: " + @user.username, initiate: true)
      redirect_to root_path
      flash[:success] = "Signed up & logged in"

    else
      flash[:error] = "Failed to create new user"
      redirect_to login_path
    end
  
    
  end

  def index
   @users = User.all
        

  end

  def show
    temp = User.where('lower(username) = ?',params[:username])
    temp.each do |t|
      @user = t
    end
  end



  private

  def user_params
    params.require(:user).permit(:username,:password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end