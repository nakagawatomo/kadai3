class BooksController < ApplicationController
  before_action :authenticate_user!


  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def show
    @Book = Book.new
    @book = Book.find(params[:id])
    @users = @book.user
  end

  def edit
    @book = Book.find(params[:id])

  if @book.user.id != current_user.id
    redirect_to books_path
    else
    render :edit
  end

  end


  def create
    @book = Book.new(book_params)
    @users = @book.user
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
      @user = @book.user
      @books = Book.all
     render :index
    end
  end


  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      @users = @book.user
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


    def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
