module Authorized
  extend ActiveSupport::Concern
  include BlockAccess

  included  do
    before_action :authorize_for_tenant!
  end

  private

  def authorize_for_tenant!
    check_authorization!(OwnedPolicy, :permit?, current_tenant)
  end

  def check_authorization!(policy_class, method, *args)
    unless policy_class.new(current_user).send(method, *args)
      block_access!
    end
  end
end