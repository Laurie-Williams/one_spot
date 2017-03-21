require 'rails_helper'

feature "Authorizations" do

  context "User tries to access owned page with non existent subdomain" do

    scenario "user is redirected to new account page and domain is reset" do
      visit owned_cases_url(subdomain: 'nonexistent')
      expect(page.current_url).to eq(new_account_url)
      expect(page).to have_selector('.flash.error')
    end
  end
end
