require 'rails_helper'

describe Voucher do
  it "is valid with a code text" do
    expect(build(:voucher)).to be_valid
  end

  it "is invalid without code text" do
    voucher = build(:voucher, code_name: nil)
    voucher.valid?
    expect(voucher.errors[:code_name]).to include("can't be blank")
  end


  it "is invalid without valid_from" do
    voucher = build(:voucher, valid_from: nil)
    voucher.valid?
    expect(voucher.errors[:valid_from]).to include("can't be blank")
  end

  it "is invalid without valid_through" do
    voucher = build(:voucher, valid_through: nil)
    voucher.valid?
    expect(voucher.errors[:valid_through]).to include("can't be blank")
  end

  it "is invalid without amount" do
    voucher = build(:voucher, amount: nil)
    voucher.valid?
    expect(voucher.errors[:amount]).to include("can't be blank")
  end

  it "is invalid without unit" do
    voucher = build(:voucher, unit: nil)
    voucher.valid?
    expect(voucher.errors[:unit]).to include("can't be blank")
  end

  it "is invalid without max amount" do
    voucher = build(:voucher, max_amount: nil)
    voucher.valid?
    expect(voucher.errors[:max_amount]).to include("can't be blank")
  end

  it "is must all capitals code" do
    voucher = build(:voucher, code_name: "vouChER")
    expect(voucher[:code_name].upcase).to eq("VOUCHER")
  end

  it "is invalid with non numerical values" do
    voucher = build(:voucher, amount: "10thousands")
    voucher.valid?
    expect(voucher.errors[:amount]).to include("is not a number")
  end

  it "is invalid with amount less than 0" do
    voucher = build(:voucher, amount: -2)
    voucher.valid?
    expect(voucher.errors[:amount]).to include("must be greater than 0")
  end

  it "is invalid with wrong units" do
    expect{ build(:voucher, unit: "Dollar") }.to raise_error(ArgumentError)
  end

end