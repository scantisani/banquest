# The controller for users.
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
