class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_user!
  def index
    articles = Article.all

    if articles.empty?
      render_error_message('There are no articles available', 404)
    else 
      render json: articles, each_serializer: Articles::IndexSerializer
    end
  end

  def create
    authorize Article.create
    @article = Article.create(article_params.merge!(journalist: current_user))

    attach_image
    if @article.persisted? && @article.image.attached?
      render json: {message: 'Article was successfully created'}
    else 
      render_error_message(@article.errors.first.to_sentence, 400)
    end   
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    attach_image
    if @article.update(article_params) && @article.image.attached?
      render json: {message: 'Edit of article went well'}, status: 200
    else
      render_error_message(@article.errors.first.to_sentence, 400)
    end
  end
  
  private
  def article_params
    params.permit(:title, :content, :author, keys: [:image])
  end

  def render_error_message(message, status)
    render json: { error_message: message }, status: status
  end

  def attach_image
    if params['image'] && params['image'].present?
      binding.pry
      DecodeService.attach_image(params['image'], @article.image)
    end
  end
end