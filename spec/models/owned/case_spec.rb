require 'rails_helper'

module Owned
  describe Case do

    # ----- Validations ----

    it { is_expected.to validate_presence_of(:name) }
  end
end
