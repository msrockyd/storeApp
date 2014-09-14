class Order < ActiveRecord::Base
  belongs_to :cart, foreign_key: :cart_id
  has_many :transactions, :class_name => "OrderTransaction"
  
  attr_accessor :card_number, :card_verification
  attr_accessor :stripe_card_token
  
  def save_with_payment(user_id)
    if valid?
      charge = Stripe::Charge.create(description: email, amount: price_in_cents, :currency => "USD", card: stripe_card_token)
      self.stripe_customer_token = charge.id
      self.user_id = user_id
      save!
      cart.update({:order_id => self.id})
      base_carts = BaseCart.where(:cart_id => cart.id)
      base_carts.each do |base_cart|
        base_cart.update({:order_id => self.id, :user_id => user_id})
      end
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  # PAYPAL INTEGRATION
  #validate :validate_card, on: :create
  # def purchase
  #   response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
  #   transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
  #   #TODO cart.update_attribute(:purchased_at, Time.now) if response.success?
  #   response.success?
  # end
  
  def price_in_cents
    #TODO should be total price of all products in cart
    #(cart.total_price*100).round
    (cart.total_price*100).round
  end

  # private
  
  # def purchase_options
  #   {
  #     :ip => ip_address,
  #     :billing_address => {
  #       :name     => "Ryan Bates",
  #       :address1 => "123 Main St.",
  #       :city     => "New York",
  #       :state    => "NY",
  #       :country  => "US",
  #       :zip      => "10001"
  #     }
  #   }
  # end
  
  # def validate_card
  #   unless credit_card.valid?
  #     credit_card.errors.full_messages.each do |message|
  #       errors.add :base, message
  #     end
  #   end
  # end
  
  # def credit_card
  #   @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
  #     :brand               => card_type,
  #     :number             => card_number,
  #     :verification_value => card_verification,
  #     :month              => card_expires_on.month,
  #     :year               => card_expires_on.year,
  #     :first_name         => name,
  #     :last_name          => last_name
  #   )
  # end
end