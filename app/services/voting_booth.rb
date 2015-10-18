# Cast or withdraw a vote on a movie
class VotingBooth
  def initialize(user, movie)
    @user  = user
    @movie = movie
  end

  def vote(like_or_hate)
    set = case like_or_hate
      when :like then @movie.likers
      when :hate then @movie.haters
      else raise
    end
    unvote # to guarantee consistency
    set.add(@user)
    _update_counts
    notify_submitter(like_or_hate)
    self
  end
  
  def unvote
    @movie.likers.delete(@user)
    @movie.haters.delete(@user)
    _update_counts
    self
  end

  def notify_submitter(like_or_hate)
    user_decorator = UserDecorator.new(@movie.user)
    if user_decorator.should_notify?
      VotingBoothMailer.voting_notification_email(@movie, @user, like_or_hate).deliver # TODO: Change this to deliver_later once we migrate to Rails 4.2
    end
  end

  private

  def _update_counts
    @movie.update(
      liker_count: @movie.likers.size,
      hater_count: @movie.haters.size)
  end
end
