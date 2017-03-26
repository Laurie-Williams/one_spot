module Owned
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :require_current_tenant
    before_action :authorize_user!

    private

    def require_current_tenant
      if current_tenant.nil?
        block_access!
      end
    end

    def authorize_user!(resource_model=Account)
      unless current_user.has_any_role?(resource_model.roles_all, current_tenant)
        block_access!
      end
    end

    def block_access!
      flash[:error] = 'Account does not exist or you do not have access to it'
      redirect_to root_url(subdomain: nil)
    end
  end
end