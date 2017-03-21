require 'rails_helper'
require 'shortcuts/account_shortcut'
require 'shortcuts/case_shortcut'
include AccountShortcut
include CaseShortcut

feature "CaseCreations" do
  scenario "User creates a case" do
    visit new_account_path
    create_account(name: 'Example Name A', subdomain: 'aaa')

    visit new_owned_case_url(subdomain: 'aaa')
    create_case(name: 'Case A1')

    visit owned_cases_url(subdomain: 'aaa')
    expect(page).to have_content('Case A1')
  end

  scenario "User only sees cases for current account" do
    visit new_account_path
    create_account(name: 'Example Name A', subdomain: 'aaa')

    visit new_account_path
    create_account(name: 'Example Name B', subdomain: 'bbb')

    visit new_owned_case_url(subdomain: 'aaa')
    create_case(name: 'Case A1')

    visit new_owned_case_url(subdomain: 'bbb')
    create_case(name: 'Case B1')

    visit owned_cases_url(subdomain: 'aaa')
    expect(page).to have_content('Case A1')
    expect(page).not_to have_content('Case B1')
  end
end
