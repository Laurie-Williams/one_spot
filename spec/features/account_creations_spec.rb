require 'rails_helper'
require 'shortcuts/account_shortcut'
require 'shortcuts/authentication_shortcut'
include AccountShortcut
include AuthenticationShortcut

feature "AccountCreations" do

  before do

    create_and_login_as(email: 'test@example.com', password: 'password')
  end

  scenario "User creates a valid account" do
    visit new_account_path
    create_account(name: 'Example Name', subdomain: 'examplesub')
    expect(current_subdomain).to eq('examplesub')
    expect(page).to have_content('Example Name')
    expect(find('.flash.success')).to have_content('Account created')
  end

  scenario "User creates an invalid account" do
    visit new_account_path
    create_account(name: '', subdomain: '')
    expect(page).to have_current_path(accounts_path)
    expect(current_subdomain).to eq('')
    expect(find('.flash.error')).to have_content('Account could not be created')
  end
end
