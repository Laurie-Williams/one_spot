require 'spec_helper'
require_relative '../../../app/biz/policies/owned_policy'

RSpec.describe OwnedPolicy do

  describe "#permit?" do
    let(:user) { double('User') }
    let(:resource) { double('resource') }
    let(:resource_class) { double('resource_class', roles_all: ['owner', 'admin']) }

    it 'returns true for users who have any role on resource' do
      allow(user).to receive(:has_any_role?).with(resource_class.roles_all, resource).and_return(true)

      expect(described_class.new(user).permit?(resource, resource_class)).to eq(true)
    end

    it 'returns false for users who do not have any role on resource' do
      allow(user).to receive(:has_any_role?).with(resource_class.roles_all, resource).and_return(false)

      expect(described_class.new(user).permit?(resource, resource_class)).to eq(false)
    end
  end
end