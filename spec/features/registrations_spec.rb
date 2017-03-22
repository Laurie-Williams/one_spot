require 'rails_helper'

feature "Registrations" do
  scenario "user registers new user" do
    visit root_url
    click_link 'register'

    fill_in "email", with: 'email@example.com'
    fill_in "password", with: 'password'
    fill_in "password_confirmation", with: 'password'
    click_button "sign_up"

    expect(page.current_url).to eq(root_path)
    expect(find('.user.email')).to eq('email@example.com')
    expect(page).to have_selector('.sign_out')
    expect(page).not_to have_selector('sign_in')
    expect(page).not_to have_selector('register')
  end
end
