require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

describe Tenanted do
  controller(ApplicationController) do
    include Tenanted

    def index
      head 200
    end
  end

  let(:user) { User.create(email: 'test@example.com', password: 'password', confirmed_at: Time.now)}

  describe "GET #index" do

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
end
