module Owned
  class Role < Owned::BaseRecord

    validates :name, presence: true
    validates :user, presence: true
    validates :resource, presence: true

    belongs_to :user
    belongs_to :resource, polymorphic: true

    # Explicitly declare Model interface for use in business logic
    # Intent to decouple business logic from ActiveRecord
    # Prefix all interface methods with 'i_'

    def self.i_where(args)
      where(args)
    end

    def self.i_find(args)
      i_where(args).first
    end

    def self.i_new(columns={})
      self.new(columns)
    end

    def self.i_destroy!(user:, resource:, name:)
      where(user: user, resource: resource, name: name).destroy_all
    end

    def self.i_create!(user:, resource:, name:)
      create!(user: user, resource: resource, name: name)
    end

    def i_save
      self.save
    end
  end
end