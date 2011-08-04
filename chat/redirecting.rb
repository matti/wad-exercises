require 'sinatra'
require 'sinatra/reloader'

require 'redis'

before do
  @redis = Redis.new
end


post "/messages" do
  @redis.rpush "messages", params[:message]
  
  redirect "chat.html"
end

get "/messages" do
  messages = @redis.lrange "messages", -3, -1
  
  messages.inspect
end
