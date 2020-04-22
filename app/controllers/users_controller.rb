class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :correct_user, only: [:edit]
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
  	@users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @book = Book.new
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def about
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render '_show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render '_show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
  @user = User.find_by(id: params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
