class WelcomeController < ApplicationController
  def index
    @user = User.where(name: params[:name])[0]
    redirect_to user_path(@user.id) if @user
  end
end
