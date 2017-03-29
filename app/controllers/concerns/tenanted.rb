module Tenanted
  extend ActiveSupport::Concern
  include BlockAccess

  included  do
    before_action :require_current_tenant
  end

  private

  def require_current_tenant
    if current_tenant.nil?
      block_access!
    end
  end
end