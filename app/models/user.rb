class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # Explicitly declare Model interface for use in business logic
  # Intent to decouple business logic from ActiveRecord
  # Prefix all interface methods with 'i_'

  def self.i_new(columns={})
    self.new(columns)
  end

  def i_save
    self.save
  end

  def has_role?(name, resource, role_model=Owned::Role)
    role_model.i_find(user: self, resource: resource, name: name) != nil
  end

  def has_any_role?(role_list, resource, role_model=Owned::Role)
    !role_model.i_where(user: self, resource: resource, role_names: role_list).empty?
  end

  def set_role!(name, resource, role_model=Owned::Role)
    return nil if self.has_role? name, resource, role_model
    role_model.i_create!(user: self, resource: resource, name: name)
  end

  def remove_role!(name, resource, role_model=Owned::Role)
    role_model.i_destroy!(user: self, resource: resource, name: name)
  end
end
