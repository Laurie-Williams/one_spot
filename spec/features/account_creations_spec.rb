require 'rails_helper'

feature "AccountCreations" do
  scenario "User creates a valid account" do
    visit new_account_path
    fill_in 'account_name', with: 'Example Name'
    fill_in 'account_subdomain', with: 'examplesub'
    click_button 'Submit'
    expect(current_subdomain).to eq('examplesub')
    expect(page).to have_content('Example Name')
    expect(find('.flash.success')).to have_content('Account created')
  end

  scenario "User creates an invalid account" do
    visit new_account_path
    fill_in 'account_name', with: ''
    fill_in 'account_subdomain', with: ''
    click_button 'Submit'
    expect(page).to have_current_path(accounts_path)
    expect(current_subdomain).to eq('www')
    expect(find('.flash.error')).to have_content('Account could not be created')
  end
end

def current_subdomain
  host = URI.parse(page.current_url).host
  ActionDispatch::Http::URL.extract_subdomain(host, 1)
end
