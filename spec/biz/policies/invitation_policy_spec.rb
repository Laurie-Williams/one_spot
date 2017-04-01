require 'spec_helper'
require_relative '../../../app/biz/policies/invitation_policy'

RSpec.describe InvitationPolicy do

  describe "#permit?" do
    let(:user) { double('User') }
    let(:resource_class) { double('AccountClass', role_owner: 'owner') }
    let(:resource) { double('Account') }
    let(:role_list) { [resource_class.role_owner] }

    it 'returns true if user has :owner role' do
      allow(user).to receive(:has_any_role?).with(role_list, resource).and_return true

      expect(described_class.new(user, resource_class).permit?(resource)).to eq(true)
    end

    it 'returns false if user does not have :owner role' do
      allow(user).to receive(:has_any_role?).with(role_list, resource).and_return false

      expect(described_class.new(user, resource_class).permit?(resource)).to eq(false)
    end
  end
end