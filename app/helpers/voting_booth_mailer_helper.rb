module VotingBoothMailerHelper
  def liked_or_hated(like_or_hate)
    if like_or_hate == :like
      "liked" # TODO: These should go in en.yml
    else
      "hated"
    end
  end
end
