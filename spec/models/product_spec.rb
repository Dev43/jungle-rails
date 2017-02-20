require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    # validation tests/examples here
    it "should successfully save as a full product" do
      category = Category.create(name: 'Home necessities')
      @product = Product.create(
        name: 'TP',
        description: "Toilet Paper",
        price_cents: 122,
        category: category,
        quantity: 2
        )

      expect(@product).to be_valid
    end

    it "should fail because no category was given" do
      @product = Product.create(
        name: 'TP',
        description: "Toilet Paper",
        price_cents: 122,
        quantity: 2,
        category: nil
        )
      expect(@product).to_not be_valid
    end

    it "should fail because no name was given" do
      category = Category.create(name: 'Home necessities')
      @product = Product.create(
        name: nil,
        description: "Toilet Paper",
        price_cents: 122,
        quantity: 2,
        category: category
        )
      expect(@product).to_not be_valid
    end

    it "should fail because no price was given" do
      category = Category.create(name: 'Home necessities')
      @product = Product.create(
        name: 'TP',
        description: "Toilet Paper",
        quantity: 2,
        category: category,
        price_cents: nil
        )
      expect(@product).to_not be_valid
    end

     it "should fail because no quantity was given" do
      category = Category.create(name: 'Home necessities')
      @product = Product.create(
        name: 'TP',
        quantity: nil,
        description: "Toilet Paper",
        price_cents: 122,
        category: category
        )
      expect(@product).to_not be_valid
    end

  end
end



#  create_table "products", force: :cascade do |t|
  #   t.string   "name"
  #   t.text     "description"
  #   t.string   "image"
  #   t.integer  "price_cents"
  #   t.integer  "quantity"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  #   t.integer  "category_id"
  # end