class BooksController < ApplicationController

	def index
		@books = Book.all.order(created_at: :desc)
	end

	def new
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)

		if @book.save
			redirect_to root_path
		else
			render :new
		end
	end

	def show
		@book = Book.find(params[:id])
	end

	def edit
		@book = Book.find(params[:id])		
	end

	def update
		@book = Book.find(params[:id])		

		if @book.update(book_params)
			redirect_to book_path(book)
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])		
		@book.destroy
		redirect_to root_path
	end

	private

	def book_params
		params.require(:book).permit(:title, :author, :description)
	end
end
