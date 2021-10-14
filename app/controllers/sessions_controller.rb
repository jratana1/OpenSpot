class SessionsController < ApplicationController
    def authenticate_google
      redirect_to '/auth/google_oauth2'
    end

    def onesignal_auth_hash
        hash= OpenSSL::HMAC.hexdigest('sha256', ENV['ONESIGNAL_API_KEY'], "#{current_user.id}")
        render json: {hash: hash}
    end
 
    def checkout
        byebug
        table= Table.find(params[:id])

        Stripe.api_key = ENV['STRIPE_API_KEY']
        session = Stripe::Checkout::Session.create({
          customer_email: current_user.email,
          line_items: [{
            # TODO: replace this with the `price` of the product you want to sell
            price_data: {
              currency: 'usd',
              product_data: {
                name: table.restaurant.name,
                description "Table for #{table.seats} at #{table.time} on #{table.seating}"
              },
              unit_amount: 10000,
            },
            quantity: 1,
          }],
          payment_method_types: [
            'card',
          ],
          mode: 'payment',
          success_url: "http://localhost:3001/#/order/success?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: 'http://localhost:3001/#/order/cancel' + '?canceled=true',
        })

        render json: {checkoutURL: session.url}
    end
end 
  