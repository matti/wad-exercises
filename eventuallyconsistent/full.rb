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

enable :sessions


post "/messages" do
  @redis.lpush "workqueue-messages", params[:message]
  
  @redis.set "messages_last_updated_at", Time.now.to_i
  session[:last_message_that_has_not_yet_been_written_to_database] = params[:message]
  redirect "/"
end

get "/" do
  etag @redis.get "messages_last_updated_at"
  
  some_slow_operation(4)
  
  @messages = @redis.lrange "messages", -20, -1

  if session[:last_message_that_has_not_yet_been_written_to_database]
    @messages << session[:last_message_that_has_not_yet_been_written_to_database]
    session[:last_message_that_has_not_yet_been_written_to_database] = nil
  end
  
  erb :chat
end


def some_slow_operation(interval)
  @redis.lpush "workqueue", interval
end