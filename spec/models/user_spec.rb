require 'spec_helper'

describe User do
  it { should have_many(:projects).through(:submissions) }
end