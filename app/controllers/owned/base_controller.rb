module Owned
  class BaseController < ApplicationController
    before_action :require_current_tenant

    private

    def require_current_tenant
      if current_tenant.nil?
        flash[:error] = 'Account does not exist or you do not have access to it'
        redirect_to new_account_url(subdomain: nil)
      end
    end
  end
end