module Owned
  class MyDevise::RegistrationsController < DeviseInvitable::RegistrationsController
    include Tenanted
    before_action :check_if_first!, only: [:new, :create]

    def new
      super
    end

    def create
      super
      if resource.persisted?
        resource.set_role!(Account.role_owner, current_tenant)
      end
    end

    private

    def check_if_first!(policy=RegistrationPolicy)
      unless policy.new.permit?
        redirect_to root_url, subdomain: nil, flash: {error: "This account already has an owner"}
      end
    end
  end
end
