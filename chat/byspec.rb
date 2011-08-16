require 'sinatra'
require 'sinatra/reloader'

require 'redis'



before do
  use Rack::Auth::Basic do |username, password|
     username == 'joe' && password == 'd34db33f'
  end

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
