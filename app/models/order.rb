class Order < ApplicationRecord
  #attr_accessor :voucher
  has_many :line_items, dependent: :destroy
  belongs_to :voucher, optional: true

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
  validates_each :voucher_id do |record, attr, value|
    if record.voucher_id.nil?
      record.errors.add(attr, "Voucher is not exist")
    end
  end

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def sub_total_price
     line_items.reduce(0) { |sum, line_items| sum + line_items.total_price }
  end

  def discount
    discount = 0
    if voucher.unit == "Percent"
      total = sub_total_price * voucher.amount * 0.01
      if total > voucher.max_amount
        discount = voucher.max_amount
      else
        discount = total
      end

    else
      discount = voucher.amount
    end
    discount
  end

  def total_price
    if voucher.nil?
      sub_total_price
    else
      sub_total_price - discount
    end
  end


end
