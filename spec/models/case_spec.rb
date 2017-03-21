require 'rails_helper'

describe Case do

  # ----- Validations ----

  it { is_expected.to validate_presence_of(:name) }
end
