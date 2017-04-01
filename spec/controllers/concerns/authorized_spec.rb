require 'rails_helper'

require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut
require 'shortcuts/tenant_shortcut'
include TenantShortcut


describe Authorized do
  controller(ApplicationController) do
    include Authorized

    def index
      head 200
    end
  end

  let(:user) { Owned::User.create(email: 'test@example.com', password: 'password', confirmed_at: Time.now)}
  let(:tenant) { double('tenant') }

  describe "GET #index" do

    before do
      stub_user_authentication(is_authenticated: true, current_user: user)
      stub_tenant tenant
    end

    context "is authorized" do
      before { allow_any_instance_of(OwnedPolicy).to receive(:permit?).with(tenant).and_return(true) }

      it "renders successful response" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "is not authorized" do
      before { allow_any_instance_of(OwnedPolicy).to receive(:permit?).with(tenant).and_return(false) }

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
end
