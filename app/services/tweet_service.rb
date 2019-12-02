class TweetService

  CONSUMER_KEY = 'W17DXTVbbFP6Eju5m5IE8bNBm'
  CONSUMER_SECRET = 'MCxUkSEX2TQFTQN2Hw23BQz91WTKa1pTMKnA3lgHupKlXLQMTX'

  OAUTH_TOKEN = '3050992760-ow9aCjG6WgrylPgAQ4OCF8ZVB8EK1l2znEvdBlr'
  OAUTH_SECRET_TOKEN = 'pAYJO12NjWve0F6m7yuNmtbHMZJGF2gYlyzbLDDVh5m3I'
  
  BASE_URL= 'https://api.twitter.com/1.1/search/tweets.json?'

  def initialize
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,{site: 'https://api.twitter.com', scheme: :header})
    token_hash = { oauth_token: OAUTH_TOKEN, oauth_token_secret: OAUTH_SECRET_TOKEN }
    @access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  def query(method_name, path, options=nil)
    response = JSON.parse(@access_token.request(method_name, path, options).body)
  end

  def search_hashtag
    response = query(:get, "#{BASE_URL}q=%23ChileDesperto%20%23chilequierecambios&result_type=recent&count=50")
    return unless response.present?
    response["statuses"].map{|status| { id: status["id"], tweet: status["text"] }}
  end
end
