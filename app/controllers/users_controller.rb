# The controller for users.
class UsersController < ApplicationController
  def index
    @users = User.all.order(best_score: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.best_score = 0
    @user.save

    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
    @user_runs = Run.where(user_id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
