require 'spec_helper'

describe Project do
  it { should have_many(:users).through(:submissions) }
  it { should validate_presence_of(:url) }
  it { should have_many(:votes) }

  describe "total_votes" do
    it "calculates total without cancelled votes" do
      project = Fabricate(:project)
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      project.votes.create(creator: user1, vote: true)
      project.votes.create(creator: user2, vote: true)
      expect(project.total_votes).to eq(2)
    end
    it "calculates total with cancelled votes" do
      project = Fabricate(:project)
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      project.votes.create(creator: user1, vote: true)
      project.votes.create(creator: user2, vote: true)
      project.votes.first.update_attributes(vote: false)
      expect(project.total_votes).to eq(1)
    end
  end
end