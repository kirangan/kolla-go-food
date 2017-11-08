require 'rails_helper'

describe Order do
  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "is valid with a name, address, email, and payment_type" do
    expect(build(:order)).to be_valid
  end

  it "is invalid without a name" do
    order = build(:order, name: nil)
    order.valid?
    expect(order.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an address" do
    order = build(:order, address: nil)
    order.valid?
    expect(order.errors[:address]).to include("can't be blank")
  end

  it "is invalid without an email" do
    order = build(:order, email: nil)
    order.valid?
    expect(order.errors[:email]).to include("can't be blank")
  end

  it "is invalid with email not in valid email format" do
    order = build(:order, email: 'email')
    order.valid?
    expect(order.errors[:email]).to include("must be valid email format")
  end

  it "is invalid without a payment_type" do
    order = build(:order, payment_type: nil)
    order.valid?
    expect(order.errors[:payment_type]).to include("can't be blank")
  end

  it "is invalid with wrong payment_type" do
    expect{ build(:order, payment_type: "Grab Pay") }.to raise_error(ArgumentError)
  end

  describe "editing line_items from cart" do
    before :each do 
      @cart = create(:cart)
      @line_item = create(:line_item, cart: @cart)
      @order = build(:order)
    end

    it "add line_items to order" do
      expect{
        @order.add_line_items(@cart)
        @order.save
      }.to change(@order.line_items, :count).by(1)
    end

    it "removes line_items from cart" do
      expect{
        @order.add_line_items(@cart)
        @order.save
      }.to change(@cart.line_items, :count).by(-1)
    end
  end

  # describe "in total_price" do

  #   context "with voucher" do
  #     it "save total_price with discount when discount is greater than max_amount" do
  #       order = create(:order)
  #       cart = create(:cart)
  #       food1 = create(:food, name: "Food 1", price: 10000.0)
  #       food2 = create(:food, name: "Food 2", price: 15000.0)
  #       line_item1 = create(:line_item, quantity: 3, food: food1, cart: cart)
  #       line_item2 = create(:line_item, quantity: 1, food: food2, cart: cart)

  #       voucher = create(:voucher, amount: 10.0, unit: "Percent", max_amount: 10000, order: order )

  #       expect(order.total_price).to eq()
  #     end

  #     it "save total_price with discount" do
  #       order = create(:order)
  #       voucher = create(:voucher, amount: 10.0, unit: "Percent", max_amount: 15000)
  #     end
  #   end
  # end

  describe "adding discount to order" do
    context "with valid voucher" do
      before :each do
        @voucher = create(:voucher, code_name: "GO_PAY", amount: 15.0, unit:"Percent", max_amount: 20000)
        @cart = create(:cart)
        @food = create(:food, price: 100000.0)
        @line_item = create(:line_item, quantity: 1, food: @food, cart: @cart)
        @order = create(:order, voucher: @voucher)
        @order.add_line_items(@cart)
      end

      it "can calculate sub total_price" do
        expect(@order.sub_total_price).to eq(100000)
      end

      context "with voucher in percent" do
        it "can calculate discount" do
          voucher = create(:voucher, code_name: "GO_DIS", amount: 10.0, unit:"Percent", max_amount: 20000 )
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          expect(order.discount).to eq(10000)
        end

        it "changes discount to max_amount if discount is bigger than max_amount" do
          voucher = create(:voucher, code_name: "GO_DS", amount: 10.0, unit:"Percent", max_amount: 5000 )
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          expect(order.discount).to eq(5000)
        end
      end

      context "with voucher in rupiah" do
        it "can calculate discount" do
          voucher = create(:voucher, amount: 5000, unit: "Rupiah", max_amount: 10000)
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          expect(order.discount).to eq(5000)
        end

        it "can calculate total_price" do
          voucher = create(:voucher, amount: 5000, unit: "Rupiah", max_amount: 10000)
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          expect(order.total_price).to eq(95000)
        end
      end

      context "with invalid voucher" do
        it "is invalid with invalid voucher" do
          order = create(:order)
          voucher = create(:voucher, voucher_id: nil, order: order)
          voucher.valid?  
          expect(voucher.errors[:voucher_id]).to include("")
        end
      end


    end
  end
end