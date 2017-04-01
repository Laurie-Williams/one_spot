require 'rails_helper'
require 'shortcuts/authentication_shortcut'
require 'shortcuts/account_shortcut'
include AuthenticationShortcut
include AccountShortcut

feature "Authorizations" do

  context "User tries to access owned page with non existent subdomain" do

    scenario "user is redirected to new account page and domain is reset" do
      visit new_owned_user_registration_url(subdomain: 'nonexistent')

      expect(page.current_url).to eq(root_url(subdomain: nil))
      expect(page).to have_selector('.flash.error')
    end
  end

  context "tries to access owned page with non member account" do

    scenario "user is redireted to root and domain is reset" do
      visit new_account_url
      create_account name: 'My Account', subdomain: 'mine'
      visit new_account_url
      create_account name: 'Not My Account', subdomain: 'notmine'

      create_and_login_as email: 'test@example.com', password: 'password', tenant_sub: 'mine', role: :owner

      visit new_owned_case_url subdomain: 'notmine'

      expect(page.current_url).to eq(root_url(subdomain: nil))
      expect(page).to have_selector('.flash.error')
    end
  end
end
