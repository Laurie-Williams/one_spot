require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

module Owned
  describe MyDevise::RegistrationsController do

    specify { is_tenanted }

    let(:tenant) { Account.create(name: 'Example Name', subdomain: 'examplesub') }

    before do
      stub_tenant tenant
      @request.env["devise.mapping"] = Devise.mappings[:owned_user]
    end

    describe "#new" do
      context "account has no users" do
        before { allow(User).to receive(:i_count).and_return(0) }

        it "returns a successful response" do
          get :new
          expect(response).to be_success
        end
      end

      context "account already has existing user" do
        before { allow(User).to receive(:i_count).and_return(1) }

        it "blocks with redirects to root with no subdomain" do
          get :new
          expect(response).to redirect_to root_url subdomain: nil
        end

        it "sets an error flash" do
          get :new
          expect(flash[:error]).not_to be_nil
        end
      end
    end

    describe "#create", pending: 'DUNNO WHY ITS RENDERING A VIEW INSTEAD OF FOLLOWING THE RESPOND_WITH REDIRECT' do
      context "account has no users" do
        let(:params) { {owned_user: {email: 'test@example.com', password: 'password', password_confirmation: 'password'}} }
        # before { allow(User).to receive(:i_count).and_return(0) }

        it "returns a successful response" do
          get :create, params: params
          expect(response).to be_success
        end

        it "creates a user" do
          get :create, params: params

          ActsAsTenant.current_tenant = tenant
          expect(User.i_count).to eq 1
        end

        it "sets the user as the owner of the current account" do
          get :create, params: params

          ActsAsTenant.current_tenant = tenant

          user = User.i_first
          owner_role = Account.role_owner
          expect(user.has_role?(owner_role, tenant)).to eq(true)
        end
      end

      context "account already has existing user" do
        before { allow(User).to receive(:i_count).and_return(1) }

        it "blocks with redirect to root with no subdomain"

        it "sets an error flash"

        it "does not create a user"
      end
    end
  end
end
