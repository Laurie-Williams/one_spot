module Owned
  class MyDevise::ConfirmationsController < Devise::ConfirmationsController
    include Tenanted
  end
end
