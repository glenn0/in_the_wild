require 'spec_helper'

describe Project do
  it { should have_many(:users).through(:submissions) }
  it { should validate_presence_of(:url) }
end