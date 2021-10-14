class SessionsController < ApplicationController
    def authenticate_google
      redirect_to '/auth/google_oauth2'
    end

    def onesignal_auth_hash
        hash= OpenSSL::HMAC.hexdigest('sha256', ENV['ONESIGNAL_API_KEY'], "#{current_user.id}")
        render json: {hash: hash}
    end
 
    def checkout

        Stripe.api_key = ENV['STRIPE_API_KEY']
        session = Stripe::Checkout::Session.create({
          line_items: [{
            # TODO: replace this with the `price` of the product you want to sell
            price_data: {
              currency: 'usd',
              product_data: {
                name: 'T-shirt',
              },
              unit_amount: 2000,
            },
            quantity: 1,
          }],
          payment_method_types: [
            'card',
          ],
          mode: 'payment',
          success_url: 'http://localhost:3001/#/' + '?success=true',
          cancel_url: 'http://localhost:3001/#/' + '?canceled=true',
        })

        render json: {checkoutURL: session.url}
    end
end 
  