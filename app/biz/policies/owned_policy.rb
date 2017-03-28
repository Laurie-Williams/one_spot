class OwnedPolicy
  def initialize(user)
    @user = user
  end

  def permit?(resource, resource_model=Account)
    @user.has_any_role?(resource_model.roles_all, resource)
  end
end