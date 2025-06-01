# Configure GoodJob for background job processing

GoodJob.configure do |config|
  # Set up queues and concurrency
  config.queues = "*"
  config.max_threads = 5

  # Configure poll interval
  config.poll_interval = 10 # seconds

  # Configure max retries for failed jobs
  config.retry_on_unhandled_error = true
  config.max_retries = 3

  # Set up custom logger
  config.logger = Rails.logger

  # Enable dashboard in all environments
  config.enable_cron = true
  config.enable_listen_notify = true

  # Use database configuration from ActiveRecord
  # config.queue_adapter_settings = { execution_mode: :async_server }
end

# Add cron job schedules
# GoodJob::Cron.add(
#   'Cleanup expired cache entries',
#   '0 0 * * *', # daily at midnight
#   CacheCleanupJob
# )
