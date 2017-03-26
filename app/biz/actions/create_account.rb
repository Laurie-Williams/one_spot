class CreateAccount
  def self.call(owner:, properties:{}, listener:, model:Account)
    DbTransaction.execute do
      self.new(owner, properties, listener, model).execute
    end
  end

  def execute
    @account = @model.i_new(@properties)
    if @account.i_save && set_owner!
      @listener.create_success(@account)
    else
      @listener.create_failure(@account)
    end
  end

  private

  def set_owner!
    set_current_tenant!
    @owner.set_role!(@model.role_owner, @account)
  end

  def set_current_tenant!
    @listener.set_current_tenant!(@account)
  end

  def initialize(owner, properties, listener, model)
    @properties = properties
    @listener = listener
    @model = model
    @owner = owner
  end
end
