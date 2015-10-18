require 'rails_helper'

RSpec.describe VotingBoothMailerHelper do

  describe "liked_or_hated" do
    it "returns liked for likes" do
      expect(helper.liked_or_hated(:like)).to eq("liked")
    end

    it "returns hated for hates" do
      expect(helper.liked_or_hated(:hate)).to eq("hated")
    end
  end
end
