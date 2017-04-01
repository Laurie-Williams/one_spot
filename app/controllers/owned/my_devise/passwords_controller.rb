module Owned
  class MyDevise::PasswordsController < Devise::PasswordsController
    include Tenanted
  end
end
