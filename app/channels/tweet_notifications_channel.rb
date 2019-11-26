class TweetNotificationsChannel < ApplicationCable::Channel
  def subscribed
    tweet = Tweet.find(params[:tweet])
    stream_from "tweets_notification_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
