class Api::BlogsController < ApplicationController
  before_action :authenticate_user
  before_action :set_blog, only: %i[show update destroy]

  # GET /api/blogs
  def index
    @blogs = Blog.all
    render json: @blogs
  end

  # GET /api/blogs/1
  def show
    render json: @blog
  end

  # POST /api/blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      render json: @blog, status: :created, location: api_blog_url(@blog)
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  private

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    unless token_valid?(token)
      render json: { error: 'Unauthorized. Token is missing or invalid.' }, status: :unauthorized
    end
  end

  def token_valid?(token)
    return false unless token
  
    begin
      secret_key_base = Rails.application.secrets.secret_key_base
      decoded_token = JWT.decode(token, nil, false)
      return true
    rescue JWT::DecodeError
      return false
    end
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
