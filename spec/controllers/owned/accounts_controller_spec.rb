require 'rails_helper'
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut

describe Owned::AccountsController do
  let(:account) {double('account', id: 1, subdomain: 'examplesub')}
  before do
    stub_tenant double('tenant')
    stub_user_authentication is_authenticated: true
  end

  describe "GET #show" do

    it "sets correct @account object" do
      allow(Account).to receive(:i_find).with('1').and_return(account)
      get :show, params: {id: 1}

      expect(assigns(:account)).to eq(account)
    end
  end
end
