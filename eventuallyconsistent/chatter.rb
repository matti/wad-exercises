require 'redis'

redis = Redis.new

messages = ["Hello!", "is there anybody here?", "who am i talking to?", "help!"]

while true do
  sleep_for = rand(3) + 1
  sleep(sleep_for)
  
  message = messages[rand(messages.length)]

  redis.rpush "messages", ("<strong>"+message+"</strong>")
  redis.set "messages_last_updated_at", Time.now.to_i
  
  sleep 1
end
