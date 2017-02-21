require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    end
  end

  scenario 'Visit home page, click add to cart and my cart item number should increase by 1' do

    visit root_path

    click_link('Add', match: :first)
    link = find('[href="/cart"]').text
    puts link
    expect(link).to eql "My Cart (1)"
    save_and_open_screenshot

  end

end
