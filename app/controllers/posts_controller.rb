class PostsController < ApplicationController

  def show
    post = find_post
    render json: post
  end

  def update
    post = find_post
    post.update!(post_params)
    render json: post, status: :ok
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  private
  
  def find_post  
    Post.find(params[:id])
  end

  def post_params
    params.permit(:category, :content, :title)
  end

end
