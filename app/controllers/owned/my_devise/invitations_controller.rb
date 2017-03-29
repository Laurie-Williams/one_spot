module Owned
  class MyDevise::InvitationsController < Devise::InvitationsController
    include OwnerRestricted
  end
end
