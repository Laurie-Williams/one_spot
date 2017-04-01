require 'rails_helper'
require 'shortcuts/authentication_shortcut'
include AuthenticationShortcut

describe Authenticated do
  controller(ApplicationController) do
    include Authenticated

    def index
      head 200
    end
  end

  let(:user) { Owned::User.create(email: 'test@example.com', password: 'password', confirmed_at: Time.now)}

  describe "GET #index" do

    context "Logged in" do
      before { stub_user_authentication(is_authenticated: true, current_user: user) }

      it "renders successful response" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "Not logged in" do

      it "redirects to sign in" do
        get :index
        expect(response).to redirect_to(new_owned_user_session_url)
      end
    end
  end
end
