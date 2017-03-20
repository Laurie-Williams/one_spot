class Account < ApplicationRecord

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  # Explicitly declare Model interface for use in business logic
  # Intent to decouple business logic from ActiveRecord

  def self.find(id)
    super(id)
  end

  def self.new(columns={})
    super(columns)
  end

  def save
    super
  end
end