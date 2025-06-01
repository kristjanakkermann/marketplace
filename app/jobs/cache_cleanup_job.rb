class CacheCleanupJob < ApplicationJob
  queue_as :default

  def perform
    # Clean up expired cache entries
    expired_entries = CacheEntry.where("expires_at < ?", Time.current)
    count = expired_entries.count

    if count > 0
      expired_entries.delete_all
      Rails.logger.info "Cleaned up #{count} expired cache entries"
    else
      Rails.logger.info "No expired cache entries to clean up"
    end
  end
end
