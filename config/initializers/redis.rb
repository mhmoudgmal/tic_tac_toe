$redis = Redis.new

puts 'REDIS has been initialized..'
puts "players.. #{$redis.lrange('players', 0, -1)}"
