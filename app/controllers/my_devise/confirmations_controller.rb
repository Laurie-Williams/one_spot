class MyDevise::ConfirmationsController < Devise::ConfirmationsController

  # Remove the unconfirmed_user_id from the session when user is confirmed
  def show
    super
    if resource.errors.empty?
      session.delete(:unconfirmed_user_id)
    end
  end

end