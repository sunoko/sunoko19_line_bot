require 'line/bot'

class LineClient
  CHANNEL_SECRET = ENV['CHANNEL_SECRET']
  CHANNEL_ACCESS_TOKEN = ENV['CHANNEL_ACCESS_TOKEN']

  attr_reader :client

  def initialize
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = CHANNEL_SECRET
      config.channel_token = CHANNEL_ACCESS_TOKEN
    }
  end

  def reply
    @client.reply_message(reply_token, text_message(message))
  end

  def push
    
  end

  private
  def text_message(text)
    {
      type: "text",
      text: text
    }
  end
end