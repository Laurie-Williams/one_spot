require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

module Owned
  describe MyDevise::InvitationsController do

    specify { is_tenanted }

    describe "#new" do

      context "user is owner" do

        it "returns a successful response"
      end

      context "user is not owner" do

        it "blocks with redirect to root"

        it "sets an error flash"
      end
    end

    describe "#create" do

      context "user is owner" do

        it "returns a successful response"

        it "creates an invitation"

        it "sets the invitee as a member of the current account"
      end

      context "user is not owner" do

        it "blocks with redirect to root"

        it "sets an error flash"

        it "does not create an invitation"
      end
    end
  end
end
