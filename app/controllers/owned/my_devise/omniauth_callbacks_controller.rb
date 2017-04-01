module Owned
  class MyDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include Tenanted
  end
end