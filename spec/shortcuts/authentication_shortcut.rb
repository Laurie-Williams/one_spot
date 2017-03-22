module AuthenticationShortcut
  def new_registration(email:, password:)
    click_link 'register'

    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    click_button "Sign up"
  end

  def confirm_registration(email:)
    open_email(email)
    current_email.click_link 'Confirm my account'
  end

  def custom_sign_in(email:, password:)
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button 'Log in'
  end
end