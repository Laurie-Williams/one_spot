class AccountsController < ApplicationController
  # -------- NEW --------

  def new
    @account = Account.i_new
  end

  # -------- CREATE --------

  def create
    CreateAccount.call(properties: account_params, listener: self)
  end

  def create_success(account)
    flash[:success] = 'Account created'
    redirect_to account_url(account.id, subdomain: account.subdomain)
  end

  def create_failure(account)
    flash.now[:error] = 'Account could not be created'
    @account = account
    render :new
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain)
  end
end
