require 'rails_helper'

describe Account do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:subdomain) }
  it { is_expected.to validate_uniqueness_of(:subdomain) }

end