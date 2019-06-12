class UsersController < ApplicationController
 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      redirect_to login_path
      flash[:success] = "User #{@user.name} is created, please login!"
    else
      
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @events_user = @user.events
    @attended_events = @user.attended_events
    @upcoming_events = @user.upcoming_events
    @prev_events = @user.previous_events
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  

end
