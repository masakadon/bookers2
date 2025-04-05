class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def create
   @book =  Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
    flash[:notice] = "you were successfully created "
    redirect_to book_path(@book.id)
   else
     @books = Book.all
     @user = current_user
     render:index
   end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
    book = Book.find(params[:id])
    unless book.user_id = current_user.id
      redirect_to book_path
    end
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "you were successfully updateed "
     redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "you were successfully deleted "
    redirect_to books_path(@books)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
     unless user == current_user
      redirect_to(books_path)
     end
  end
end
