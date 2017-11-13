require 'rails_helper'

describe Food do

	it "is valid with a name and description" do
		expect(build(:food)).to be_valid
	end

  it "is invalid without a name" do
    food = build(:food, name: nil)
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    food = build(:food, description: nil)
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

	it "is invalid with a duplicate name" do
    food1 = create(:food, name: "Nasi Goreng")
    food2 = build(:food, name: "Nasi Goreng")

    food2.valid?
    expect(food2.errors[:name]).to include("has already been taken")
  end

  it "is valid price" do
    expect(build(:food)).to be_valid
  end

  it "is invalid with non numerical values price" do
    food = build(:food, price: "100rb")
    food.valid?
    expect(food.errors[:price]).to include("is not a number")
  end

  it "is invalid with price less than 0.01" do
    food = build(:food, price: 0.00)
    food.valid?
    expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it "is valid image_url" do
    expect(build(:food)).to be_valid
  end

  it "is invalid image url, must be ends with '.gif', '.jpg', and '.png'" do
    food = build(:food, image_url: "https://i.imgur.com/lWNdCHS.doc")
    food.valid?
    expect(food.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG image.")
  end

  describe "filter name by letter" do 
    before :each do 
      @food1 = create(:food, name: "Nasi Goreng")
      @food2 = create(:food, name: "Kerak Telor")
      @food3 = create(:food, name: "Nasi Semur Jengkol")
    end

    context "with matching letter" do
      it "returns a sorted array of results that match" do
        expect(Food.by_letter("N")).to eq([@food1, @food3])
      end
    end
    context "with non-matching letter" do
      it "omits results that do not match" do
        expect(Food.by_letter("N")).not_to eq(@food2)
      end
    end
  end 

  it "can't be destroyed while it has line_item(s)" do
    cart = create(:cart)
    food = create(:food)

    line_item = create(:line_item, cart: cart, food: food)
    food.line_items << line_item

    expect { food.destroy }.not_to change(Food, :count)
  end

  describe "relations" do
    it { should have_and_belong_to_many(:tags) }
    it { belong_to(:category) }
  end
end