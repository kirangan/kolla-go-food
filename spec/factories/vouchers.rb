FactoryGirl.define do
  factory :voucher do
    code_name 'GETVOUCHER'
    valid_from '2017-11-06 00:00:00'
    valid_through '2017-11-15 00:00:00'
    amount 15.0
    unit 'Percent'
    max_amount 10000
  end

  factory :invalid_voucher, parent: :voucher do
    code_name nil
    valid_from nil
    valid_through nil
    amount nil
    unit nil
    max_amount nil
  end
end