class Voucher < ApplicationRecord
  before_save :set_upcase
  before_destroy :ensure_not_referenced_by_any_order
  has_many :orders

  enum unit: {
    "Percent" => 0,
    "Rupiah" => 1
  }

  validates :code_name, :valid_from, :valid_through, :amount, :unit, :max_amount, presence: true
  validates :code_name, uniqueness: {case_sensitive: false }
  validates :amount, :max_amount, numericality: { greater_than: 0 }
  validates :unit, inclusion: units.keys
  #validates_with :DiscountDateValidator
  validates_each :valid_through do |record, attr, value|
    if !value.nil? && !record.valid_from.nil?
      record.errors.add(attr, "valid_from must be less that valid_through") if value < record.valid_from
    end
  end

  validates_each :max_amount do |record, attr, value|
    if record.unit == "Rupiah"
      record.errors.add(attr, "must be greater than or equal to amount") if value < record.amount
    end
  end

  private
  def ensure_not_referenced_by_any_order
    unless  orders.empty?
      errors.add(:base, 'Orders present')
      throw :abort
    end
  end

  def set_upcase
    code_name.upcase!
  end

end
