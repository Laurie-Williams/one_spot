class RegistrationPolicy
  def initialize(user_class:Owned::User)
    @user_class = user_class
  end

  def permit?
    @user_class.i_count === 0
  end
end