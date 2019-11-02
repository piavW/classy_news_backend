class Api::V0::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:stripeToken]
      begin
        customer =
          Stripe::Customer.create(
            email: current_user.email, source: params[:stripeToken]
          )
  
        charge =
          Stripe::Charge.create(
            customer: customer.id,
            amount: 10_000,
            description: 'Gnosis Yearly Subscription',
            currency: 'sek'
          )
  
        if charge.paid?
          current_user.update_attribute(:subscriber, true)
          render json: { message: 'Payment successful' }
        else    
          render_error(charge.errors)
        end

      rescue => error
        render_error(error.message)
      end
    else
      render_error('No stripe token detected')
    end
    
  end

  def new; end

  private

  def render_error(message)
    render json: { 
      errors: message
    }, status: 402
  end
end