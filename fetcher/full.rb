require 'sinatra'
require 'sinatra/reloader'


get "/" do

  erb :giveurl
end

post "/fetch" do
  
  redirect "/waiting"
end


get "/waiting" do
  
  erb :waiting
  
end
