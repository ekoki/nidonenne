Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["HEROKU_REDIS_ORANGE_URL"],
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV["HEROKU_REDIS_ORANGE_URL"],
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end