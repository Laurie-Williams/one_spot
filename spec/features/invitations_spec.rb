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

    visit new_owned_user_invitation_url subdomain: 'examplesub'

    fill_in :owned_user_email, with: 'invited@example.com'
    click_button 'Send an invitation'

    logout :owned_user

    open_email('invited@example.com')
    current_email.click_link 'Accept invitation'

    fill_in :owned_user_password, with: 'password'
    fill_in :owned_user_password_confirmation, with: 'password'
    click_button 'Set my password'

    expect(current_url).to eq(root_url(subdomain: 'examplesub'))
    expect(find('.user_email')).to have_content('invited@example.com')
    expect(find('.user_role')).to have_content(Account.role_member)
    expect(page).to have_selector('.flash.notice')
  end

  scenario "members cannot invite new users" do
    create_and_login_as email: 'member@example.com', password: 'password', tenant_sub: 'examplesub', role: Account.role_member

    visit new_owned_user_invitation_url subdomain: 'examplesub'

    expect(current_url).to eq(root_url(subdomain: 'examplesub'))
    expect(page).to have_selector('.flash.error')
  end
end
