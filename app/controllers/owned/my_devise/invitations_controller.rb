module Owned
  class MyDevise::InvitationsController < Devise::InvitationsController
    include Tenanted
    before_action :check_if_authorized!, only: [:new, :create]

    def create
      super do |invitee|
        if invited? invitee
          set_as_member! invitee
        end
      end
    end

    private

    def invited?(invitee)
      invitee.errors.empty?
    end

    def set_as_member!(invitee)
      invitee.set_role!(Account.role_member, current_tenant)
    end

    def check_if_authorized!(policy:InvitationPolicy)
      unless policy.new(current_user).permit?(current_tenant)
        flash[:error] = 'Your not authorized for this action'
        redirect_to root_path
      end
    end
  end
end
