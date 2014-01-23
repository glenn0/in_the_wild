require 'spec_helper'

describe Tag do
  it { should have_many(:projects).through(:project_tags) }
  it { should validate_presence_of(:name) }
end