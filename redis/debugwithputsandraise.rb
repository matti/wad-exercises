require 'sinatra'
require 'sinatra/reloader'

require 'redis'

get '/redis' do
 redis = Redis.new
 
 puts redis.inspect
 raise redis.inspect
  
 redis.set "hello", "world"
 
 value = redis.get "hello"
 return value
end


get '/' do
  "hello world"
end


