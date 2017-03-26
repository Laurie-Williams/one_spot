module TransactionShortcut
  def stub_transactions
    allow(DbTransaction).to receive(:execute).and_yield
  end
end