class MyDevise::RegistrationsController < Devise::RegistrationsController

  # Set unconfirmed_user_id in the session so that user can create associated
  # Account before they have confirmed
  def create
    super
    if resource.save
      session[:unconfirmed_user_id] = resource.id
    end
  end

end