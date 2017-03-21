require 'rails_helper'

describe CasesController do
  let(:kase) { double('case') }

  describe "GET #new" do

    before do
      allow(Case).to receive(:i_new).and_return(kase)
    end

    it "responds with success status code" do
      get :new
      expect(response).to be_success
    end

    it "sets new case instance to @case" do
      get :new
      expect(assigns(:case)).to eq(kase)
    end
  end

  describe "POST #create" do
    before do
      allow(Case).to receive(:i_new).and_return(kase)
    end

    describe "creation successful" do
      let(:permitted_params) {ActionController::Parameters.new({name: 'Example Name'}).permit(:name)}

      before do
        allow(CreateCase).to receive(:call).with(properties: permitted_params, listener: controller) { controller.create_success}
        post :create, params: {case: permitted_params.to_h}
      end

      it "sends properties and listener to CreateCase action service" do
        expect(CreateCase).to have_received(:call).with(properties: permitted_params, listener: controller) { controller.create_success }
      end

      it "sets success flash" do
        expect(flash[:success]).not_to eq(nil)
      end

      it "redirects to correct account url" do
        expect(response).to redirect_to(cases_url)
      end
    end

    describe "creation unsuccessful" do
      let(:permitted_params) {ActionController::Parameters.new({name: ''}).permit(:name)}

      before do
        allow(CreateCase).to receive(:call).with(properties: permitted_params, listener: controller) { controller.create_failure(kase) }
        post :create, params: {case: permitted_params.to_h}
      end

      it "sets error flash" do
        expect(flash[:error]).not_to be_nil
      end

      it "renders new template" do
        expect(response).to render_template('new')
      end

      it "sets @account with received account object" do
        expect(assigns(:case)).to eq(kase)
      end
    end
  end

end
