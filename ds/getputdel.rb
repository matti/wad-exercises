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