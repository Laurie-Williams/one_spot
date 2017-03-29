require 'rails_helper'
require 'shortcuts/tenant_shortcut'
require 'shortcuts/authentication_shortcut'
include TenantShortcut
include AuthenticationShortcut

describe OwnerRestricted do
  controller(ApplicationController) do
    include OwnerRestricted

    def index
      head 200
    end
  end

  let(:account) {double('account', id: 1, subdomain: 'examplesub')}
  let(:user) { User.create(email: 'test@example.com', password: 'password', confirmed_at: Time.now)}

  describe "GET #index" do

    context "Logged in" do
      before { stub_user_authentication(is_authenticated: true, current_user: user) }

      context "with current tenant" do
        before { stub_tenant double('tenant') }

        context "and has role permission" do
          before { allow(user).to receive(:has_any_role?).and_return(true) }

          it "renders successful response" do
            get :index
            expect(response).to have_http_status(:success)
          end
        end

        context "and does not have role permission" do
          before { allow(user).to receive(:has_any_role?).and_return(false) }

          it "redirects to root" do
            get :index
            expect(response).to redirect_to root_url(subdomain: nil)
          end

          it "sets error flash" do
            get :index
            expect(flash[:error]).not_to be_nil
          end
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
