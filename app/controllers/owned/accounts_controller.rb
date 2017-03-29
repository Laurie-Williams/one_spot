module Owned
  class AccountsController < ApplicationController
    include OwnerRestricted
    # -------- SHOW --------

    def show
      @account = Account.i_find(params[:id])
    end
  end
end
