require 'rails_helper'

describe Voucher do

  it "has valid factory" do
    expect(build(:voucher)).to be_valid
  end

  it "is valid with a code_name, valid_from, valid_through, amount, unit, and max_amount" do
    expect(build(:voucher)).to be_valid
  end

  it "is invalid without a code text" do
    voucher = build(:voucher, code_name: nil)
    voucher.valid?
    expect(voucher.errors[:code_name]).to include("can't be blank")
  end


  it "is invalid without a valid_from" do
    voucher = build(:voucher, valid_from: nil)
    voucher.valid?
    expect(voucher.errors[:valid_from]).to include("can't be blank")
  end

  it "is invalid without a valid_through" do
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

  it "in invalid with a duplicate code_name" do
    voucher1 = create(:voucher, code_name: "PROMO")
    voucher2 = build(:voucher, code_name: "PROMO")
    voucher2.valid?
    expect(voucher2.errors[:code_name]).to include("has already been taken")
  end

  it "saves code in all capitals letter" do
    voucher = create(:voucher, code_name: "voucher")
    expect(voucher.code_name).to eq("VOUCHER")
  end

  it "is invalid with case sensitive duplicate code_name" do
    voucher1 = create(:voucher, code_name: "VOUCHER")
    voucher2 = build(:voucher, code_name: "voucher")
    voucher2.valid?
    expect(voucher2.errors[:code_name]).to include("has already been taken")
  end

  it "is invalid with non numerical amount" do
    voucher = build(:voucher, amount: "10thousands")
    voucher.valid?
    expect(voucher.errors[:amount]).to include("is not a number")
  end

  it "is invalid with non numerical max_amount" do
    voucher = build(:voucher, max_amount: "abcs")
    voucher.valid?
    expect(voucher.errors[:max_amount]).to include("is not a number")
  end

  it "is invalid with amount less than 0" do
    voucher = build(:voucher, amount: -2)
    voucher.valid?
    expect(voucher.errors[:amount]).to include("must be greater than 0")
  end

  it "is invalid with max_amount less than 0" do
    voucher = build(:voucher, max_amount: -2)
    voucher.valid?
    expect(voucher.errors[:max_amount]).to include("must be greater than 0")
  end

  it "is invalid valid_through < valid_from" do
    voucher = build(:voucher, valid_from: '2017-11-06', valid_through: '2017-11-02')
    voucher.valid?
    expect(voucher.errors[:valid_through]).to include("valid_from must be less that valid_through")
  end

  it "is invalid with wrong unit" do
    expect{ build(:voucher, unit: "dollar")
      }.to raise_error(ArgumentError)
  end

  context "with unit value rupiah" do
    it "is invalid with max_amount less than amount" do
      voucher = build(:voucher, unit: 1, amount: 5000, max_amount: 3000)
      voucher.valid?
      expect(voucher.errors[:max_amount]).to include("must be greater than or equal to amount")
    end
  end

  it "can't be destroyed while it has order(s)" do
    voucher = create(:voucher)
    order = create(:order, voucher: voucher)

    expect { voucher.destroy }.not_to change(Voucher, :count)
  end
end