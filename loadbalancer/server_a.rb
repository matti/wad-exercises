require 'sinatra'
require 'sinatra/reloader'


set :port, 10_000

get '/whoami' do
  "A"
end