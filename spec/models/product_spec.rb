require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    # validation tests/examples here

    before(:each) do
    category = Category.create(name: 'Home necessities')
    @product = Product.new(
      name: 'TP',
      description: "Toilet Paper",
      price_cents: 122,
      category: category,
      quantity: 2
    )
    end

    it "should successfully save as a full product" do
      @product.save
      expect(@product).to be_valid
    end

    it "should fail because no category was given" do
      @product.category =  nil
      @product.save
      expect(@product).to_not be_valid
    end

    it "should fail because no name was given" do
      @product.name = nil
      @product.save
      expect(@product).to_not be_valid
    end

    it "should fail because no price was given" do
      @product.price_cents = nil
      @product.save
      expect(@product).to_not be_valid
    end

     it "should fail because no quantity was given" do
      @product.quantity = nil
      @product.save
      expect(@product).to_not be_valid
    end

  end
end
