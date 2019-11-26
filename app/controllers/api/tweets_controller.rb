class Api::TweetsController < ApplicationController
  def index
    tweets = Tweet.all
    render json: tweets
  end
  
  def create
    byebug
    tweet = Tweet.new(tweet_params)
    if tweet.save
      sealized_data = ActiveModelSerializers::Adapter::Json.new(
        TweetSerializer.new(tweet)
      ).serializable_hash
      ActionCable.server.broadcast 'tweet_notification_channel', serialized_data
      head :ok
    end
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end