
require 'redis'

redis = Redis.new

print "Waiting for work"

while (true) do
  
  if work = redis.lpop("workqueue")
    puts "\nGOT WORK! #{work}"
    sleep(4)
    puts "Finished working"
  end
    
  print "."
  

  sleep 1
end