class InvitationPolicy
  def initialize(user, resource_model=Account)
    @user = user
    @resource_model = resource_model
  end

  def permit?(resource)
    @user.has_any_role?(permitted_roles, resource)
  end

  private

  def permitted_roles
    [@resource_model.role_owner]
  end
end