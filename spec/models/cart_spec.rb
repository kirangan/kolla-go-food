require 'rails_helper'

describe Cart do
  it "has a valid factory" do
    expect(build(:cart)).to be_valid
  end

  it "deletes line_items when deleted" do
    cart = create(:cart)
    food1 = create(:food)
    food2 = create(:food)

    line_item1 = create(:line_item, cart: cart, food: food1)
    line_item2 = create(:line_item, cart: cart, food: food2)
    cart.line_items << line_item1
    cart.line_items << line_item2

    expect { cart.destroy }.to change { LineItem.count }.by(-2)
  end

  it "does not change the number of line_item if the same food is added" do
    cart = create(:cart)
    food = create(:food, name: "Nasi Uduk")
    line_item = create(:line_item, food: food, cart: cart)

    expect{ cart.add_food(food) }.not_to change(LineItem, :count)
  end

  it "increment the quantity of line_item if the same food is added" do
    cart = create(:cart)
    food = create(:food, name: "Nasi Uduk")
    line_item = create(:line_item, food: food, cart: cart)

    expect(cart.add_food(food).quantity).to eq(2)
  end

  it "can calculate total price" do
    cart = create(:cart)
    food_1 = create(:food, name: "Nasi uduk",price:2000)
    line_item_1 = create(:line_item, quantity: 2, food: food_1, cart: cart)
    food_2 = create(:food, price:5000, name: "nasi goreng")
    line_item_2 = create(:line_item, food: food_2, quantity: 1, cart: cart)

    expect(cart.total_price).to eq(9000)
  end
end
