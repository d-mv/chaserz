$redis = Redis.new

url = ENV["REDISCLOUD_URL"]

if ENV["REDISCLOUD_URL"]
    $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end




# if url
#   Sidekiq.configure_server do |config|
#     config.redis = { url: url }
#   end

#   Sidekiq.configure_client do |config|
#     config.redis = { url: url }
#   end
#   $redis = Redis.new(:url => url)
# end
