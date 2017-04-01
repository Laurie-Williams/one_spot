require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut
require 'shortcuts/authorization_shortcut'
include AuthorizationShortcut
require 'shortcuts/owner_restricted_shortcut'
include OwnerRestrictedShortcut

describe Owned::AccountsController do
  let(:account) {double('account', id: 1, subdomain: 'examplesub')}
  let(:user) {double('user')}
  before do
    stub_tenant double('tenant')
    stub_user_authentication is_authenticated: true, current_user: user
    stub_user_authorization current_user: user, is_authorized: true
  end

  specify { is_authenticated }
  specify { is_authorized }
  specify { is_tenanted }

  describe "GET #show" do

    it "sets correct @account object" do
      allow(Account).to receive(:i_find).with('1').and_return(account)
      get :show, params: {id: 1}

      expect(assigns(:account)).to eq(account)
    end
  end
end
