class BooksController < ApplicationController

	def index
		if params[:book_category].blank?
			@books = Book.all.order(created_at: :desc)
		else
			@book_category_id = BookCategory.find_by(name: params[:book_category]).id
			@books = Book.where(:book_category_id => @book_category_id).order(created_at: :desc)
		end
	end

	def new
		@book = current_user.books.build
		@book_categories = BookCategory.all.map {|c| [c.name, c.id]}
	end

	def create
		@book = current_user.books.build(book_params)
		@book.book_category_id = params[:book_category_id]

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
		@book_categories = BookCategory.all.map {|c| [c.name, c.id]}		
	end

	def update
		@book = Book.find(params[:id])		
		@book.book_category_id = params[:book_category_id]
		
		if @book.update(book_params)
			redirect_to book_path(@book)
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
		params.require(:book).permit(:title, :author, :description, :book_category_id)
	end
end
