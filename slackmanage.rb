require 'http'
require 'json'
require 'eventmachine'
require 'faye/websocket'
require 'sinatra'
# require 'puma'
# require 'slack-ruby-bot'
 
# get '/anonymize' do
#   content_type :json
#   {:text => params[:text], :response_type => "in_channel"}.to_json
# end

Thread.new do 
	EM.run do
	end
end

get '/' do 
	if params.key?('code')
		rc = HTTP.post("https://slack.com/api/oauth.access", params: {
			client_id: ENV['SLACK_CLIENT_ID'],
			client_secret: ENV['SLACK_CLIENT_SECRET'],
			code: params['code']
		})

		rc = JSON.parse(rc)

		token = rc['bot']['bot_access_token']

		rc = JSON.parse(HTTP.post("https://slack.com/api/rtm.start", params: {
			token: token
		}))

		url = rc['url']

		ws = Faye::WebSocket::Client.new(url)
			
		ws.on :open do
			p [:open]
		end

		ws.on :message do |event|
			p [:message, JSON.parse(event.data)]
			data = JSON.parse(event.data)
			if data['text'] == 'hi'
				ws.send({ type: 'message',
					text: "hi <@#{data['user']}>",
					channel: data['channel'] }.to_json)
			end
		end

		ws.on :close do |event|
			p [:close, event.code, event.reason]
			ws = nil 
			EM.stop
		end

		"Bot Successfully Installed"
	
	else
		"Hello World"
	end
end






