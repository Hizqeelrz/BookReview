class BookCategoriesController < ApplicationController

	def index
		@book_categories = BookCategory.all
	end

	def new
		@book_category = BookCategory.new
	end

	def create
		@book_category = BookCategory.new(category_params)

		if @book_category.save
			redirect_to root_path
		else
			render :new
		end
	end

	def show
		@book_category = BookCategory.find(params[:id])
	end

	def edit
		@book_category = BookCategory.find(params[:id])
	end

	def update
		@book_category = BookCategory.find(params[:id])
		
		if @book_category.update(category_params)
			redirect_to book_category_path(@book_category)
		else
			render :edit
		end
	end

	def destroy
		@book_category = BookCategory.find(params[:id])
		@book_category.destroy
		redirect_to root_path		
	end

	private

	def category_params
		params.require(:book_category).permit(:name)
	end
end
