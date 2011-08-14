require 'sinatra'
require 'sinatra/reloader'

require 'redis'

before do
  @redis = Redis.new
end


get "/cachetesting" do
  
  etag "unique-2"
  
  puts "About to do something really slow"
  sleep 1
  puts "still doing it"
  sleep 1
  puts "not quite finished"
  sleep 1
  puts "wow this is a big task"
  sleep 1

  return "Finished at " + Time.now.to_s

end



post "/messages" do
  @redis.rpush "messages", params[:message]
  
  redirect "/"
end

get "/" do
  @messages = @redis.lrange "messages", -3, -1

  erb :chat
end
