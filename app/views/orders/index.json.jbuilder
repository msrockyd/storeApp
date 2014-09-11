json.array!(@orders) do |order|
  json.extract! order, :id, :cart_id, :ip_address, :name, :card_type, :card_expires_on
  json.url order_url(order, format: :json)
end
