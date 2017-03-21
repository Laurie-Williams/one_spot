require_relative '../../../app/biz/actions/create_account'

RSpec.describe CreateAccount do
  let(:account) { double('account', i_save: true) }
  let(:account_class) { double('account_class', i_new: account) }
  let(:params) { double('params') }
  let(:listener) { double('listener', create_success: nil, create_failure: nil) }

  it "passes params to account #i_new" do
    CreateAccount.call(properties: params, listener: listener, model: account_class)

    expect(account_class).to have_received(:i_new).with(params)
  end

  describe "successful creation" do
    before do
      allow(account).to receive(:i_save).and_return(true)
    end

    it "calls #create_successful on the listener with correct account instance" do
      CreateAccount.call(properties: params, listener: listener, model: account_class)
      expect(listener).to have_received(:create_success)
    end
  end

  describe "unsuccessful creation" do
    before do
      allow(account).to receive(:i_save).and_return(false)
    end

    it "calls #create_failed on the listener with correct account instance" do
      CreateAccount.call(properties: params, listener: listener, model: account_class)
      expect(listener).to have_received(:create_failure)
    end
  end
end