require 'rails_helper'

RSpec.describe VotingBoothMailer do
  describe "voting_notification_email" do
    before do
      @author = User.create(
          uid:  'null|12345',
          name: 'Bob',
          email: 'bob@bob.com'
      )
      @voter = User.create(
          uid:  'null|54321',
          name: 'John'
      )
      @movie = Movie.create(
          title:        'Empire strikes back',
          description:  'Who\'s scruffy-looking?',
          date:         '1980-05-21',
          created_at:   Time.parse('2014-10-01 10:30 UTC').to_i,
          user:         @author,
      )
    end

    it "renders a like email" do
      mail = VotingBoothMailer.voting_notification_email(@movie, @voter, :like)

      expect(mail.subject).to eq("Your movie has received a vote") # has teaser subject
      expect(mail.to).to eq([@author.email]) # goes to movie author
      expect(mail.body).to match(@author.name) # Has author name
      expect(mail.body).to match(@voter.name) # Has voter name
      expect(mail.body).to match(@movie.title) # Has movie name
      expect(mail.body).to match("liked") # Has the vote up/down description
      expect(mail.body).to match("Congratulations") # Has the "yay" part
    end

    it "renders a hate email" do
      mail = VotingBoothMailer.voting_notification_email(@movie, @voter, :hate)

      expect(mail.subject).to eq("Your movie has received a vote") # has teaser subject
      expect(mail.to).to eq([@author.email]) # goes to movie author
      expect(mail.body).to match(@author.name) # Has author name
      expect(mail.body).to match(@voter.name) # Has voter name
      expect(mail.body).to match(@movie.title) # Has movie name
      expect(mail.body).to match("hated") # Has the vote up/down description
      expect(mail.body).to match("discourage") # Has the "booh" part
    end
  end
end
