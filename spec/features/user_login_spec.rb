require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    
    @user = User.create!(name: "Claire Loo", email: 'c@c.Com', password:'1234', password_confirmation: '1234')
  end

  scenario "users can login successfully and are taken to the home page once they are signed in." do
    
    # ACT
    visit root_path

    click_on 'Login'

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    find('.btn').click
    # puts page.html

    # DEBUG / VERIFY
    # save_screenshot
    expect(page).to have_selector :link, @user.email, href: '#'
    expect(page).to have_selector :css, '.products-index'
  end

end
