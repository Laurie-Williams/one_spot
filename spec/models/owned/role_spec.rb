require 'rails_helper'
require 'rspec/active_model/mocks'

describe Owned::Role do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:resource) }

  let(:user) { User.i_new(email: 'test@example.com', password: 'password', confirmed_at: Time.new(2000)) }
  let(:other_user) { User.i_new(email: 'test@example.com', password: 'password', confirmed_at: Time.new(2000)) }
  let(:account) { Account.i_new(name: 'Example Name', subdomain: 'Example') }
  let(:role_name) { 'owner' }

  describe "#self.i_find" do
    describe "matching role exists" do
      before do
        @role = described_class.i_new( user: user, resource: account, name: role_name)
        @role.i_save
      end

      it "returns matching role instance" do
        expect(described_class.i_find(user: user, resource: account, name: role_name)).to eq(@role)
      end
    end

    describe "matching role does not exist" do

      it "returns nil" do
        expect(described_class.i_find(user: user, resource: account, name: role_name)).to eq(nil)
      end
    end
  end

  describe "#self.i_where" do

    describe "matching roles exist" do
      let(:role_1) { described_class.i_create!( user: user, resource: account, name: 'role_1') }
      let(:role_2) { described_class.i_create!( user: user, resource: account, name: 'role_2') }
      let(:unowned_role) { described_class.i_create!( user: other_user, resource: account, name: 'unowned_role') }

      it "returns only matching roles in list" do
        role_list = [role_1.name, role_2.name]
        expect(described_class.i_where(user: user, resource: account, role_names: role_list)).to contain_exactly(role_1, role_2)
      end
    end

    describe "matching role does not exist" do

      it "returns nil" do
        role_list = ['role_1', 'role_2']
        expect(described_class.i_where(user: user, resource: account, role_names: role_list)).to be_empty
      end
    end
  end

  describe "#self.i_create!" do

    it "creates correct record" do
      expect(described_class.first).to eq(nil)

      described_class.i_create!(user: user, resource: account, name: role_name)

      record = described_class.first
      expect(record.user).to eq(user)
      expect(record.resource).to eq(account)
      expect(record.name).to eq(role_name)
    end

    it "raises an error on failure" do
      expect{ described_class.i_create!(user: nil, resource: nil, name: nil) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "#i_destroy!" do
    before do
      @role = described_class.i_new( user: user, resource: account, name: role_name)
      @role.i_save
    end

    it "deletes correct record" do
      expect(described_class.first).to eq(@role)

      described_class.i_destroy!(user: user, resource: account, name: role_name)

      expect(described_class.first).to eq(nil)
    end
  end
end
