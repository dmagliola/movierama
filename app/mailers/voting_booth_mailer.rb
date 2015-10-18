class VotingBoothMailer < ActionMailer::Base
  default from: "notifications@movierama.dev"

  def voting_notification_email(movie, voter, like_or_hate)
    @recipient = movie.user
    @movie = movie
    @voter = voter
    @like_or_hate = like_or_hate
    mail to: @recipient.email, subject: "Your movie has received a vote" # Teaser subject to get them to open the email
  end
end
