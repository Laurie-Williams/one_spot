module TenantShortcut
  def stub_tenant(tenant_instance)
    allow(ActsAsTenant).to receive(:current_tenant).and_return tenant_instance
  end

  def is_tenanted
    expect(described_class.ancestors.include? Tenanted).to eq(true)
  end
end