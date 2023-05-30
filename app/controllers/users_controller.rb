class UsersController < ApplicationController

    before_action :authenticate_user!


  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
      @books = Book.all
     redirect_to books_path
    end
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all
  end



  def edit
  @user = User.find(params[:id])

  if @user.id != current_user.id
  redirect_to user_path(current_user)
  else
    render :edit
  end

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user.id)
    else
      @users = User.all
      render :edit
    end
  end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end




end