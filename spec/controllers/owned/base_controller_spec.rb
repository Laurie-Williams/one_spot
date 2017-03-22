require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

describe Owned::BaseController do
  controller do
    def index
      head 200
    end
  end

  let(:account) {double('account', id: 1, subdomain: 'examplesub')}
  let(:user) { User.create(email: 'test@example.com', password: 'password', confirmed_at: Time.now)}

  describe "GET #index" do

    context "Logged in" do
      before { sign_in user }

      context "with current tenant" do
        before { stub_tenant double('tenant') }

        it "renders successful response" do
          get :index
          expect(response).to have_http_status(:success)
        end
      end

      context "without current tenant" do
        before { stub_tenant nil }

        it "redirects to root" do
          get :index
          expect(response).to redirect_to root_url(subdomain: nil)
        end
      end
    end

    context "Not logged in" do

      context "with current tenant" do
        before { stub_tenant double('tenant') }

        it "redirects to sign in" do
          get :index
          expect(response).to redirect_to(new_user_session_url)
        end
      end

      context "without current tenant" do
        before { stub_tenant nil }

        it "redirects to root" do
          get :index
          expect(response).to redirect_to(new_user_session_url)
        end
      end
    end
  end
end
