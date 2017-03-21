class CreateAccount
  def self.call(properties:{}, listener:, model:Account)
    self.new(properties, listener, model).execute
  end

  def execute
    account = @model.i_new(@properties)
    if account.i_save
      @listener.create_success(account)
    else
      @listener.create_failure(account)
    end
  end

  private

  def initialize(properties, listener, model)
    @properties = properties
    @listener = listener
    @model = model
  end
end
