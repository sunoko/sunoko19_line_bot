class TweetsController < ApplicationController
  def search
    @tweets = []
    if params[:keyword].present?
      get_tweets(initialize_twitter_client).take(10).each do |tw|
        @tweets << Tweet.new(tw.full_text)
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @tweets }
    end
  end
  
  private
    def initialize_twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end
    end
    def get_tweets(twitter_client)
      twitter_client.search(params[:keyword],
                            count: 10,
                            result_type: "recent",
                            exclude: "retweets",
                            since_id: nil)
    end
end
