module BlockAccess

  private

  def block_access!
    flash[:error] = 'Account does not exist or you do not have access to it'
    redirect_to root_url(subdomain: nil)
  end
end