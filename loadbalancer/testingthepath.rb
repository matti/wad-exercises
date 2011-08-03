require 'sinatra'
require 'sinatra/reloader'


get '*' do
  params[:splat].inspect
end