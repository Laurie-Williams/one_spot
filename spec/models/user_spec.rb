require 'rails_helper'

module Owned
  describe User do
    def stub_role_find_with(args:, response:)
      allow(role_class).to receive(:i_find).with(args).and_return(response)
    end

    def stub_role_where_with(args:, response:)
      allow(role_class).to receive(:i_where).with(args).and_return(response)
    end

    let(:user) { User.new }
    let(:account) { double(:account) }
    let(:role) {double(:role)}
    let(:role_class) {double(:role_class, i_find: nil)}

    describe "#has_role?" do

      describe "user has :owner role on account" do
        before { stub_role_find_with args: {user: user, resource: account, name: :owner}, response: role }

        it "returns true when passed role :owner and instance :account" do
          expect(role_class.i_find(user: user, resource: account, name: :owner)).to eq(role)
          expect(user.has_role?(:owner, account, role_class)).to eq(true)
        end
      end

      describe "user does not have :owner role on account" do
        before { stub_role_find_with args:     {user: user, resource: account, name: :owner},
                                     response: nil }

        it "returns false when passed role :owner and instance :account" do
          expect(user.has_role?(:owner, account, role_class)).to eq(false)
        end
      end
    end

    describe "#has_any_role?" do

      describe "role list includes a user's role" do
        let(:role_list) { [:role1, :owner, :role2] }
        before { stub_role_where_with args: {user: user, resource: account, name: role_list}, response: [role] }

          it "returns true" do
            expect(user.has_any_role?(role_list, account, role_class)).to eq(true)
          end
      end

      describe "role list does not include any user's role" do
        let(:role_list) { [:role1, :role2] }
        before { stub_role_where_with args: {user: user, resource: account, name: role_list}, response: [] }

        it "returns false" do
          expect(user.has_any_role?(role_list, account, role_class)).to eq(false)
        end
      end
    end

    describe "#set_role!" do

      describe "role does not exist" do
        before { allow(user).to receive(:has_role?).with(:owner, account, role_class).and_return(false) }

        it "creates the correct role" do
          allow(role_class).to receive(:i_create!).with(user: user, resource: account, name: :owner).and_return(role)
          user.set_role!(:owner, account, role_class)

          expect(role_class).to have_received(:i_create!).with(user: user, resource: account, name: :owner)
        end
      end

      describe "role already exists" do
        before { allow(user).to receive(:has_role?).with(:owner, account, role_class).and_return(true) }

        it "does not create role" do
          allow(role_class).to receive(:i_create!)
          user.set_role!(:owner, account, role_class)

          expect(role_class).to_not have_received(:i_create!).with(user: user, resource: account, name: :owner)
        end
      end
    end

    describe "#remove_role!" do

      before do
        allow(user).to receive(:has_role?).with(:owner, account).and_return(true)
        allow(role_class).to receive(:i_destroy!)
      end

      it "deletes the role" do
        user.remove_role!(:owner, account, role_class)
        expect(role_class).to have_received(:i_destroy!).with(user: user, resource: account, name: :owner)
      end
    end
  end
end

