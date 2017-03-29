module OwnerRestrictedShortcut
  def is_owner_restricted
    expect(described_class.ancestors.include? OwnerRestricted).to eq(true)
  end
end