class WelcomeController < ApplicationController
  def index
    @user = User.new
  end

  def search
    @user = User.where(name: params[:name])

    redirect_to @user
  end
end
