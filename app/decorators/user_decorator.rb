class UserDecorator < Draper::Decorator
  delegate_all

  def likes?(movie)
    movie.likers.include?(object)
  end

  def hates?(movie)
    movie.haters.include?(object)
  end

  def should_notify?
    object.notify_me && object.email.present?
  end
end

