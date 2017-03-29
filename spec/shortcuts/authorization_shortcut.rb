include Warden::Test::Helpers

module AuthorizationShortcut

  # ----- Controller Specs -----

  def stub_user_authorization(current_user:,is_authorized:)
    allow(current_user).to receive(:has_any_role?).and_return(is_authorized)
  end

  def is_authorized
    expect(described_class.ancestors.include? Authorized).to eq(true)
  end
end