require 'rails_helper'

describe Owned::AccountsController do
  let(:account) {double('account', id: 1, subdomain: 'examplesub')}
  before { stub_tenant double('tenant') }

  describe "GET #show" do

    it "sets correct @account object" do
      allow(Account).to receive(:i_find).with('1').and_return(account)
      get :show, params: {id: 1}

      expect(assigns(:account)).to eq(account)
    end
  end
end
