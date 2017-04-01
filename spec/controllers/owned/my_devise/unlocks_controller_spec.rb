require 'rails_helper'
require 'shortcuts/tenant_shortcut'
include TenantShortcut

module Owned
  describe MyDevise::UnlocksController do

    specify { is_tenanted }
  end
end
