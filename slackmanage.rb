require 'sinatra'
require 'httparty'
require 'json'
 
get '/anon' do
  content_type :json
  {:text => params[:text], :response_type => "in_channel"}.to_json
end



