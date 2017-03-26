class AccountsController < ApplicationController
  set_current_tenant_through_filter
  # -------- NEW --------

  def new
    @account = Account.i_new
  end

  # -------- CREATE --------

  def create
      CreateAccount.call(owner: current_user, properties: account_params, listener: self)
  end

  def create_success(account)
    flash[:success] = 'Account created'
    redirect_to owned_account_url(account.id, subdomain: account.subdomain)
  end

  def create_failure(account)
    flash.now[:error] = 'Account could not be created'
    @account = account
    render :new
  end

  def set_current_tenant!(account)
    ActsAsTenant.current_tenant = account
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain)
  end
end
