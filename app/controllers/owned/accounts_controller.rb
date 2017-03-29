module Owned
  class AccountsController < ApplicationController
    include Authenticated
    include Tenanted
    include Authorized

    # -------- SHOW --------

    def show
      @account = Account.i_find(params[:id])
    end
  end
end
