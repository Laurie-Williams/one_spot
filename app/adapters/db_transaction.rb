module DbTransaction
  def self.execute &block
    ActiveRecord::Base.transaction(&block)
  end
end