require 'sinatra'
require 'sinatra/reloader'

require 'redis'

before do
  @redis = Redis.new
end

post '/hello' do
  @redis.set 'hello', params[:who]
  "ok"
end

get '/hello' do
  @redis.get "hello"
end
