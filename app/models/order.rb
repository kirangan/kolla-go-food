class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  
  enum payment_type: {
    "Cash" => 0,
    "Go Pay" => 1,
    "Credit Cart" => 2
  }

  validates :name, :address, :email, :payment_type, presence: true
  validates :email, format: {
    with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: 'must be valid email format'
  }
  validates :payment_type, inclusion: payment_types.keys

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def total_price
    line_items.reduce(0) { |sum, line_items| sum + line_items.total_price }
  end
end
