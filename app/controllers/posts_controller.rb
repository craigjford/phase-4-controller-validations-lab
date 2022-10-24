class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    post = find_post
    render json: post
  end

  def update
    post = find_post
    post.update!(post_params)
    render json: post
  #  rescue ActiveRecord::RecordInvalid => error
  #   render json: { error: error.message }, status: :unprocessable_entity
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { message: invalid.record.errors.full_messages }, status: :unprocessable_entity 
  end

  private
  
  def find_post  
    Post.find(params[:id])
  end

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_not_found_response(error)
    render json: { message: error.message }, status: :not_found
    # render json: { error: "Post not found" }, status: :not_found
  end

  # def render_unprocessable_entity_response(invalid)  
  #   render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  # end
end
