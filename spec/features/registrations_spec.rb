require 'rails_helper'
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut

feature "Registrations" do
  let(:email) { 'text@example.com' }
  let(:password) { 'password' }

  scenario "user registers new user" do
    visit root_url
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    # User needs to confirm registration by email
    expect(page.current_url).to eq(root_url)
    expect(page).to have_selector('.flash.notice')
    expect(page).not_to have_selector('.user.email')
  end

  scenario "user confirms registration by email" do
    clear_emails

    visit root_url
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    expect(page.current_url).to eq(new_user_session_url)
    expect(page).to have_selector('.flash.notice')
  end

  scenario "user signs in successfully" do
    clear_emails

    visit root_url
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    custom_sign_in(email: email, password: password)

    expect(page.current_url).to eq(root_url)
    expect(page).to have_selector('.flash.notice')
    expect(find('.user_email')).to have_content(email)
  end
end
