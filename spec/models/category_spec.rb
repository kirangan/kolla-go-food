require 'rails_helper'

describe Category do

  it "is valid with a name" do
    expect(build(:category)).to be_valid
  end

  it "is invalid without a name" do
    category = build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end 

  it "is invalid with a duplicate name" do
    category1 = create(:category, name: "pedas")
    category2 = build(:category, name: "pedas")
    category2.valid?
    expect(category2.errors[:name]).to include("has already been taken")
  end
end