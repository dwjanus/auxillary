require 'sinatra'
require 'httparty'
require 'json'
require 'slack-ruby-bot'
 
# get '/anonymize' do
#   content_type :json
#   {:text => params[:text], :response_type => "in_channel"}.to_json
# end

class SamanageBot < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end
end

SamanageBot.run 





