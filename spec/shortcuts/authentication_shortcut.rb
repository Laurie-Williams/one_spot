include Warden::Test::Helpers

module AuthenticationShortcut

  # ----- Feature Specs -----

  def new_registration(email:, password:)
    click_link 'register'

    fill_in "owned_user_email", with: email
    fill_in "owned_user_password", with: password
    fill_in "owned_user_password_confirmation", with: password
    click_button "Sign up"
  end

  def confirm_registration(email:)
    open_email(email)
    current_email.click_link 'Confirm my account'
  end

  def custom_sign_in(email:, password:)
    fill_in "owned_user_email", with: email
    fill_in "owned_user_password", with: password
    click_button 'Log in'
  end

  def create_and_login_as(email:, password:, tenant_sub:, role:)
    account = Account.i_where(subdomain: tenant_sub).first
    user = Owned::User.i_new(email: email, password: password, confirmed_at: Time.now, account: account)
    user.save
    role = Owned::Role.create(user: user, resource: account, name: role, account: account)
    login_as user
  end

  # ----- Controller Specs -----

  def stub_user_authentication(is_authenticated:, current_user:)
    allow(controller).to receive(:authenticate_user!).and_return(is_authenticated)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  def is_authenticated
    expect(described_class.ancestors.include? Authenticated).to eq(true)
  end
end