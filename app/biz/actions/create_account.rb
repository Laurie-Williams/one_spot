class CreateAccount
  def self.call(properties:{}, listener:)
    self.new(properties, listener).execute
  end

  def execute
    account = Account.i_new(@properties)
    if account.i_save
      @listener.create_success(account)
    else
      @listener.create_failure(account)
    end
  end

  private

  def initialize(properties, listener)
    @properties = properties
    @listener = listener
  end
end