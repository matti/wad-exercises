require 'redis'

redis = Redis.new

while true do
  message = redis.lpop "workqueue-messages"
  
  if message
    redis.rpush "messages", message
    redis.set "messages_last_updated_at", Time.now.to_i
  
    puts message

  end
  
  sleep 1
end
  