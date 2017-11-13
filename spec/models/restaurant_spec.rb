require 'rails_helper'

describe Restaurant do
  it "has a valid factory" do
    expect(build(:restaurant)).to be_valid
  end

  it "is valid with a name and a address" do
    expect(build(:restaurant)).to be_valid
  end

  it "is invalid without a name" do
    restaurant = build(:restaurant, name: nil)
    restaurant.valid?
    expect(restaurant.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a address" do
    restaurant = build(:restaurant, address: nil)
    restaurant.valid?
    expect(restaurant.errors[:address]).to include("can't be blank")
  end

end