require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut

feature "Invitations" do

  before do
    acc = Account.i_new(name: 'Example Name', subdomain: 'examplesub')
    acc.i_save
    stub_tenant acc
  end

  scenario "owners can invite new users who receive role of member" do
    create_and_login_as email: 'owner@example.com', password: 'password', tenant_sub: 'examplesub', role: Account.role_owner

    visit new_invitations_url subdomain: 'examplesub'

    fill_in 'email', with: 'invited@example.com'
    click_button 'submit'

    log_out :owned_user

    open_email('invited@example.com')
    current_email.click_link 'Confirm my account'

    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'password'
    click_button 'submit'

    expect(current_page).to eq(root_url(subdomain: 'examplesub'))
    expect(find('user_email')).to have_content('invited@example.com')
    expect(find('user_role')).to have_content(Account.role_member)
    expect(flash[:success]).not_not be_nil
  end

  scenario "members cannot invite new users" do
    create_and_login_as email: 'member@example.com', password: 'password', tenant_sub: 'examplesub', role: Account.role_member

    visit new_invitations_url subdomain: 'examplesub'

    expect(current_url).to eq(root_url(subdomain: 'examplesub'))
    expect(flash[:error]).not_to be_nil
  end
end
