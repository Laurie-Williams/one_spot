class Account < ApplicationRecord

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  # Explicitly declare Model interface for use in business logic
  # Intent to decouple business logic from ActiveRecord
  # Prefix all interface methods with 'i_'

  def self.i_find(id)
    self.find(id)
  end

  def self.i_new(columns={})
    self.new(columns)
  end

  def self.i_where(columns={})
    self.where(columns)
  end

  def i_save
    self.save
  end

  def self.roles_all
    [role_owner]
  end

  def self.role_owner
    'owner'
  end
end