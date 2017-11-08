class DiscountDateValidator < ActiveModel::Validator
  def validate(record)
    if record.valid_through > record.valid_from
      errors.add(:expiration_date, "must be greater than valid_from")
    end
  end
  
end