require 'sinatra'
require 'sinatra/reloader'


set :port, 10_001

get '/whoami' do
  sleep 2
  "B"
end
