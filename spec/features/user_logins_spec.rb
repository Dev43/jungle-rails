require 'rails_helper'

RSpec.feature "UserLogins", type: :feature , js: true do

  before :each do
    User.create!(
      name:"Patrick",
      email: '1@1',
      password: '1234',
      password_confirmation: '1234'
      )
  end


  scenario ' users can login successfully and are taken to the home page once signed in' do

    visit '/login'

    fill_in 'email', with: '1@1'
    fill_in 'password', with: '1234'
    click_on 'Submit'

    expect(page).to have_css('[href="/logout"]')
    save_and_open_screenshot

  end


end
