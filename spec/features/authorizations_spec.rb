require 'rails_helper'
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut

feature "Authorizations" do

  context "User tries to access owned page with non existent subdomain" do
    before do
      create_and_login_as email: 'test@example.com', password: 'password'
    end

    scenario "user is redirected to new account page and domain is reset" do
      visit owned_cases_url(subdomain: 'nonexistent')
      expect(page.current_url).to eq(root_url(subdomain: nil))
      expect(page).to have_selector('.flash.error')
    end
  end
end
