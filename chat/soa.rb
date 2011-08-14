require 'sinatra'
require 'sinatra/reloader'

require 'redis'

set :port, 10100

before do
  @redis = Redis.new
end


post "/messages" do
  @redis.rpush "messages", params[:message]
  
  redirect "/"
end

get "/" do
  @messages = @redis.lrange "messages", -3, -1

  erb :chat
end
