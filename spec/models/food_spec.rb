require 'rails_helper'

describe Food do
	it "is valid with a name and description" do
		food = Food.new(
			name: "Nasi uduk",
			description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
			price: 10000.0
			)
		expect(food).to be_valid
	end

  describe "presence of name and description" do
    before :each do
      @food = Food.new(
      name: nil,
      description: nil,
      price: 10000.0
      )
    end

    context "with name" do
      it "is invalid without a name" do
        @food.valid?
        expect(@food.errors[:name]).to include("can't be blank")
      end
    end

    context "with description" do
      it "is invalid without a description" do
        @food.valid?
        expect(@food.errors[:description]).to include("can't be blank")
      end
    end

  end

	it "is invalid with a duplicate name" do
    food1 = Food.create(
      name: "Nasi uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
      )
    food2 = Food.new(
      name: "Nasi uduk",
      description: "Just with a different description",
      price: 10000.0
      )
    food2.valid?
    expect(food2.errors[:name]).to include("has already been taken")
  end

  it "is invalid with non numerical values price" do
    food = Food.new(
      name: "Nasi uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: "10ribu"
      )
    food.valid?
    expect(food.errors[:price]).to include("is not a number")
  end

  it "is invalid with price less than 0.01" do
    food = Food.new(
      name: "Nasi uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 0.0
      )
    food.valid?
    expect(food.errors[:price]).to include("must be greater than or equal to #{0.01}")
  end

  it "is invalid image url, must be ends with '.gif', '.jpg', and '.png'" do
    food = Food.new(
      name: "Nasi uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0,
      image_url: "https://i.imgur.com/lWNdCHS.doc"
      )
    food.valid?
    expect(food.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG image.")
  end

  describe "filter name by letter" do 
    before :each do 
      @food1 = Food.create(
      name: "Nasi uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0
      )
      @food2 = Food.create(
      name: "Kerak Telor",
      description: "Betawi traditional spicy omelette made from glutinous rice cooked bla bla bla",
      price: 8000.0
      )
      @food3 = Food.create(
      name: "Nasi Semur Jengkol",
      description: "Based on dongfruit, this menu promises i don't know ",
      price: 8000.0
      )
    end

    context "with matching letter" do
      it "returns a sorted array of results that match" do
        expect(Food.by_letter("N")).to eq([@food3, @food1])
      end
    end

    context "with non-matching letter" do
      it "omits results that do not match" do
        expect(Food.by_letter("N")).not_to eq(@food2)
      end
    end
  end
end