json.extract! buyer, :id, :name, :phone, :email, :address, :created_at, :updated_at
json.url buyer_url(buyer, format: :json)
