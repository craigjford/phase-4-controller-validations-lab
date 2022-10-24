class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def show
    author = find_author
    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    # render json: { errors: invalid.record.errors }, status: :unprocessable_entity   
  end

  private
  
  def find_author       
    Author.find(params[:id])
  end

  def author_params
    params.permit(:email, :name)
  end
  
  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

end
