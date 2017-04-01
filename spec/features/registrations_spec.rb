require 'rails_helper'
require 'shortcuts/authentication_shortcut'
require 'shortcuts/account_shortcut'
include AuthenticationShortcut
include AccountShortcut

feature "Registrations" do
  let(:email) { 'text@example.com' }
  let(:password) { 'password' }

  before do
    visit new_account_url
    create_account(name: 'Example Name', subdomain: 'examplesub')
  end

  scenario "user registers new user" do
    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    # User needs to confirm registration by email
    expect(page.current_url).to eq(root_url subdomain: 'examplesub')
    expect(page).to have_selector('.flash.notice')
    expect(page).not_to have_selector('.user.email')
  end

  scenario "user confirms registration by email" do
    clear_emails

    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    expect(page.current_url).to eq(new_owned_user_session_url subdomain: 'examplesub')
    expect(page).to have_selector('.flash.notice')
  end

  scenario "user signs in successfully" do
    clear_emails

    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    custom_sign_in(email: email, password: password)

    expect(page.current_url).to eq(root_url subdomain: 'examplesub')
    expect(page).to have_selector('.flash.notice')
    expect(find('.user_email')).to have_content(email)
  end

  scenario "first user under account can register" do
    clear_emails

    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    custom_sign_in(email: email, password: password)

    expect(page.current_url).to eq(root_url subdomain: 'examplesub')
    expect(find('.user_email')).not_to be_nil
  end

  scenario "signups after the account owner are blocked" do

    create_and_login_as email: 'owner@example.com', password: 'password', tenant_sub: 'examplesub', role: :owner
    logout :owned_user

    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    click_link 'register'

    expect(page.current_url).to eq(root_url subdomain: 'examplesub')
    expect(page).to have_selector('.flash.error')
    expect(page).not_to have_selector('.user.email')
  end

  scenario "first user under account is given role of owner" do
    clear_emails

    visit root_url subdomain: 'examplesub'
    expect(page).not_to have_selector('.user.email')

    new_registration email: email, password: password

    confirm_registration email: email

    custom_sign_in(email: email, password: password)

    expect(page.current_url).to eq(root_url subdomain: 'examplesub')
    expect(find('.user_role')).to have_content('owner')
  end
end
