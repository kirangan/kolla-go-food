class Voucher < ApplicationRecord
  
  enum unit: {
    "Percent" => 0,
    "Rupiah" => 1
  }

  validates :code_name, :valid_from, :valid_through, :amount, :unit, :max_amount, presence: true
  validates :code_name, uniqueness: true
  validates :amount, numericality: { greater_than: 0 }
  validates :unit, inclusion: units.keys

end