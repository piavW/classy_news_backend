class Api::V1::ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: { article: @articles }
  end
end