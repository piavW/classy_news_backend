class Api::V1::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    if  @user.update(user.params)
      render json: {message: 'User role was changed'}
    else 
      render_error_message('Cant change user role', 300)
    end   
  end
  
private
  def article_params
    params.permit(:email, :password, :role, :country)
  end

  def render_error_message(message, status)
    render json: { error_message: message }, status: status
  end
end
