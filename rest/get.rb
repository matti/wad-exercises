require 'sinatra'
require 'sinatra/reloader'

require 'redis'


before do
  @redis = Redis.new
end

post "/greetings" do
  id = @redis.incr "greeting_id"
  
  @redis.set "greeting:#{id}", params[:greeting]  

  id.inspect
end

get "/greetings/:id" do
  value = @redis.get "greeting:#{params[:id]}"
  
  if value
    value
  else
    status 404
  end
end
