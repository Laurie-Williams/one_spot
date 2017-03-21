require_relative '../../../app/biz/actions/create_case'

module Owned
  RSpec.describe CreateCase do
    let(:kase) { double('case', i_save: true) }
    let(:kase_class) { double('kase_class', i_new: kase) }
    let(:params) { double('params') }
    let(:listener) { double('listener', create_success: nil, create_failure: nil) }

    it "passes params to case #i_new" do
      CreateCase.call(properties: params, listener: listener, model: kase_class)

      expect(kase_class).to have_received(:i_new).with(params)
    end

    describe "successful creation" do
      before do
        allow(kase).to receive(:i_save).and_return(true)
      end

      it "calls #create_successful on the listener with correct account instance" do
        CreateCase.call(properties: params, listener: listener, model: kase_class)
        expect(listener).to have_received(:create_success)
      end
    end

    describe "unsuccessful creation" do
      before do
        allow(kase).to receive(:i_save).and_return(false)
      end

      it "calls #create_failed on the listener with correct account instance" do
        CreateCase.call(properties: params, listener: listener, model: kase_class)
        expect(listener).to have_received(:create_failure)
      end
    end
  end
end
