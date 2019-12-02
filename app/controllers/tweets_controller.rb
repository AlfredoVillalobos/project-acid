class TweetsController < ApplicationController
  def index
    @tweets = $redis.get('tweets')
    if @tweet.nil?
      @tweets = TweetService.new.search_hashtag.to_json
      $redis.set("tweets", @tweets)
      $redis.expire("tweets", 5.seconds.to_i)
    end
    render json: @tweets
  end
  
  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end