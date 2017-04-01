module Owned
  class MyDevise::SessionsController < Devise::SessionsController
    include Tenanted
  end
end

