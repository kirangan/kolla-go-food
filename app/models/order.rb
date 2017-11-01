class Order < ApplicationRecord

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


end
