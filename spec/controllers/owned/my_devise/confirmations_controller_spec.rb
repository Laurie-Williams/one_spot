require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

module Owned
  describe MyDevise::ConfirmationsController do

    specify { is_tenanted }
  end
end
