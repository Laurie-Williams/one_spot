module Owned
  class BaseRecord < ApplicationRecord
    self.abstract_class = true

    acts_as_tenant(:account)
  end
end