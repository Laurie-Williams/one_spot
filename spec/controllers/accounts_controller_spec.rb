require 'rails_helper'

describe AccountsController do
  let(:account) {double('account', id: 1, subdomain: 'examplesub')}

  describe "GET #new" do

    before do
      allow(Account).to receive(:new).and_return(account)
    end

    it "responds with success status code" do
      get :new
      expect(response).to be_success
    end

    it "sets new account instance to @account" do
      get :new
      expect(assigns(:account)).to eq(account)
    end
  end

  describe "POST #create" do
    let(:permitted_params) {ActionController::Parameters.new({name: 'Example Name', subdomain: 'examplesub'}).permit(:name, :subdomain)}

    describe "creation successful" do

      before do
        allow(CreateAccount).to receive(:call).with(properties: permitted_params, listener: controller) { controller.create_success(account) }
        post :create, params: {account: {name: 'Example Name', subdomain: 'examplesub'}}
      end

      it "sends properties and listener to CreateAccount service" do
        expect(CreateAccount).to have_received(:call).with(properties: permitted_params, listener: controller) { controller.create_success(account) }
      end

      it "sets success flash" do
        expect(flash[:success]).not_to eq(nil)
      end

      it "redirects to correct account url" do
        expect(response).to redirect_to(account_url(account.id, subdomain: account.subdomain))
      end
    end

    describe "creation unsuccessful" do

      before do
        allow(CreateAccount).to receive(:call).with(properties: permitted_params, listener: controller) { controller.create_failure(account) }
        post :create, params: {account: {name: 'Example Name', subdomain: 'examplesub'}}
      end

      it "sets error flash" do
        expect(flash[:error]).not_to be_nil
      end

      it "renders new template" do
        expect(response).to render_template('new')
      end

      it "sets @account with received account object" do
        expect(assigns(:account)).to eq(account)
      end
    end
  end

  describe "GET #show" do

    it "sets correct @account object" do
      allow(Account).to receive(:find).with('1').and_return(account)
      get :show, params: {id: 1}

      expect(assigns(:account)).to eq(account)
    end
  end
end
