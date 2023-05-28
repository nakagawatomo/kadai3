class UsersController < ApplicationController
  
  
  def index
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit

  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end


end
