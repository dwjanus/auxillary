require 'sinatra'
require 'httparty'
require 'json'
 
get '/anonymize' do
  postback params[:text], params[:channel_id]
  status 200
end
 
def postback message, channel
    slack_webhook = ENV['https://hooks.slack.com/services/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']
    HTTParty.post slack_webhook, body: {"text" => message.to_s, "username" => "John Doe", "channel" => params[:channel_id]}.to_json, headers: {'content-type' => 'application/json'}
end


