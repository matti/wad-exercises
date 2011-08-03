require 'sinatra'
require 'sinatra/reloader'

require 'redis'

get '/redis' do
 redis = Redis.new
 redis.set "hello", "world"

 value = redis.get "hello"
 return value
end


get '/' do
  "hello world"
end


