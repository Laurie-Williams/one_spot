module Owned
  class AccountsController < Owned::BaseController
    # -------- SHOW --------

    def show
      @account = Account.i_find(params[:id])
    end
  end
end
