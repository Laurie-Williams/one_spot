class Case < ApplicationRecord

  acts_as_tenant(:account)
  validates :name, presence: true

  # Explicitly declare Model interface for use in business logic
  # Intent to decouple business logic from ActiveRecord
  # Prefix all interface methods with 'i_'

  def self.i_new(columns={})
    self.new(columns)
  end

  def self.i_all
    self.all
  end

  def i_save
    self.save
  end
end