require 'redis'

redis = Redis.new

while (true) do
  
  work_units = redis.llen 'workqueue'
  
  puts "X" * work_units
    
  sleep 1
end