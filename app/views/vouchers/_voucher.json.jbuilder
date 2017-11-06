json.extract! voucher, :id, :code_name, :valid_from, :valid_through, :amount, :unit, :max_amount, :created_at, :updated_at
json.url user_url(user, format: :json)
