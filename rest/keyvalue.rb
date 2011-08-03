require 'sinatra'
require 'sinatra/reloader'

require 'redis'


before do
  @redis = Redis.new
end

put "/:key" do
  @redis.set params[:key], params[:value]  
  
  ""
end

get "/:key" do
  value = @redis.get params[:key]
  
  if value
    value
  else
    status 404
  end
end

delete "/:key" do
  keys_deleted = @redis.del params[:key]

  if keys_deleted == 1
    ""
  else
    status 404
  end
  
end

