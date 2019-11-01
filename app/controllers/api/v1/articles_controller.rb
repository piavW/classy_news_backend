class Api::V1::ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
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
    if Article.exists?(id: params[:id]) 
      @article = Article.find(params[:id])
      authorize @article
      render json: @article, serializer: Articles::IndexSerializer
    else
      render_error_message('The article could not be found', 404)
    end
  end

  def update
    @article = Article.find(params[:id])
    authorize @article

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
      DecodeService.attach_image(params['image'], @article.image)
    end
  end
end