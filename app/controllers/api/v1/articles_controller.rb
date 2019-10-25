class Api::V1::ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: { title: 'Trump Impeachment'}
  end
end
