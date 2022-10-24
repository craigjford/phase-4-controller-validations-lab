class AuthorsController < ApplicationController

  def show
    author = find_author
    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created  
  end

  private
  
  def find_author       
    Author.find(params[:id])
  end

  def author_params
    params.permit(:email, :name)
  end

end
