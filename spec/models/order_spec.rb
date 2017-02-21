require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'After creation' do
    before :each do
      @product1 = Product.create!(
        name: 'TP',
        description: "Toilet Paper",
        price_cents: 122,
        category: Category.create(name: 'Home necessities'),
        quantity: 2
      )
      @product2 = Product.create!(
        name: 'Towel',
        description: "Towel",
        price_cents: 1212,
        category: Category.create(name: 'Home necessities'),
        quantity: 10
      )

      @product3 = Product.create!(
        name: 'Soap',
        description: "it's soap!",
        price_cents: 1212,
        category: Category.create(name: 'Home necessities'),
        quantity: 10
      )
    end
    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(
        total_cents: 300,
        stripe_charge_id: 122,
        email: '1@1'
        )
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
        )

       @order.line_items.new(
        product: @product2,
        quantity: 5,
        item_price: @product2.price,
        total_price: @product2.price * 5
        )
      @order.save!


      @product1.reload
      @product2.reload
      expect(@product1.quantity).to eql 0
      expect(@product2.quantity).to eql 5
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      expect(@product3.quantity).to eql 10
    end
  end
end
