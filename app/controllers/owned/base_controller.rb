module Owned
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_tenant
    before_action :authorize_for_tenant!

    private

    def require_current_tenant
      if current_tenant.nil?
        block_access!
      end
    end

    def authorize_for_tenant!
      check_authorization!(OwnedPolicy, :permit?, current_tenant)
    end

    def check_authorization!(policy_class, method, *args)
      unless policy_class.new(current_user).send(method, *args)
        block_access!
      end
    end

    def block_access!
      flash[:error] = 'Account does not exist or you do not have access to it'
      redirect_to root_url(subdomain: nil)
    end
  end
end