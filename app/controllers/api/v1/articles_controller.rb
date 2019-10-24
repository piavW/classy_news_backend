class Api::V1::ArticlesController < ApplicationController
  def index
    render json: { title: 'Trump Impeachment'}
  end
end
