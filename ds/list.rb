require 'sinatra'
require 'sinatra/reloader'

require 'redis'


before do
  @redis = Redis.new
end


put "/keys/:key" do
  @redis.set params[:key], params[:value]
  
  ""
end

get "/keys/:key" do
  value = @redis.get params[:key]
  
  if value
    value
  else
    status 404
  end
end

delete "/keys/:key" do
  keys_deleted = @redis.del params[:key]
  
  if keys_deleted == 1
    ""
  else
    status 404
  end
end


# Integers

post "/keys/:key/increment" do
  @redis.incr params[:key]
end

post "/keys/:key/decrement" do
  @redis.decr params[:key]
end


# List

get "/lists/:list/length" do
  length = @redis.llen params[:list]
  
  length.to_s
end

post "/lists/:list" do
  @redis.lpush params[:list], params[:value]
end

delete "/lists/:list/pop" do
  @redis.lpop params[:list]
end
