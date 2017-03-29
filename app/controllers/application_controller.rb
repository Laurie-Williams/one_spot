class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_raven_context
  set_current_tenant_by_subdomain :account, :subdomain

  private

  def set_raven_context
    #Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def check_authorization!(policy_class, method, *args)
    unless policy_class.new(current_user).send(method, *args)
      block_access!
    end
  end
end
