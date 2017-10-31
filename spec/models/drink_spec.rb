require 'rails_helper'

describe Drink do
  it "is valid with a name and description" do
    expect(build(:drink)).to be_valid
  end

  it "is invalid without a name" do
    drink = build(:drink, name: nil)
    drink.valid?
    expect(drink.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    drink = build(:drink, description: nil)
    drink.valid?
    expect(drink.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    drink1 = create(:drink, name: "Fun Soda")
    drink2 = build(:drink, name: "Fun Soda")

    drink2.valid?
    expect(drink2.errors[:name]). to include("has already been taken")
  end

  it "is valid price" do
    expect(build(:drink)).to be_valid
  end

  it "is invalid with non numerical values price" do
    drink = build(:drink, price: "10ribu")
    drink.valid?
    expect(drink.errors[:price]).to include("is not a number")
  end

  it "is invalid with price less than 0.01" do
    drink = build(:drink, price: 0)
    drink.valid?
    expect(drink.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it "is valid image url" do
    expect(build(:drink)).to be_valid
  end

  it "is invalid image url, must be ends '.gif', '.jpg', and '.png'" do
    drink = build(:drink, image_url: "http://1.bp.blogspot.com/-ErIW_mI1a_A/UeZWRVGgUCI/AAAAAAAACKg/jo0M3rfiR5A/s1600/ES+MEGA+MENDUNG.html")
    drink.valid?
    expect(drink.errors[:image_url]).to include("must be a URL for GIF, JPG, or PNG image.")
  end

  describe "filter name by letter" do
    before :each do
      @drink1 = create(:drink, name: "Fun soda")
      @drink2 = create(:drink, name: "Big Cloud")
      @drink3 = create(:drink, name: "Blewah Ice")
    end

    context "with matching letter" do
      it "return a sorted array of results that match" do
        expect(Drink.by_letter("B")).to eq([@drink2, @drink3])
      end
    end

    context "with non-matching letter" do
      it "omits results that do not match" do
        expect(Drink.by_letter("B")).not_to eq(@drink1)
      end
    end
  end

  it "can't be destroyed while it has line_items(s)" do
    cart = create(:cart)
    drink = create(:drink)

    line_item = create(:line_item, cart: cart, drink: drink)
    drink.line_items << line_item

    expect { drink.destroy }.not_to change(Drink, :count)
  end
end