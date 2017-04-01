module Owned
  class MyDevise::UnlocksController < Devise::UnlocksController
    include Tenanted
  end
end
