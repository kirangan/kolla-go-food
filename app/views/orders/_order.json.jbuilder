json.extract! order, :id, :name, :email, :address, :payment_type :created_at, :updated_at
json.url order_url(order, format: :json)
