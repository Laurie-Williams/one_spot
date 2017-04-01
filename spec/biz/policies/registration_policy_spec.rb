require 'spec_helper'
require_relative '../../../app/biz/policies/registration_policy'

RSpec.describe RegistrationPolicy do

  describe "#permit?" do
    let(:user_class) { double('User') }

    it 'returns true if account has no existing users' do
      allow(user_class).to receive(:i_count).and_return(0)

      expect(described_class.new(user_class: user_class).permit?).to eq(true)
    end

    it 'returns false if account has existing users' do
      allow(user_class).to receive(:i_count).and_return(1)

      expect(described_class.new(user_class: user_class).permit?).to eq(false)
    end
  end
end