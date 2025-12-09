module RedisCacheSweeper
  extend ActiveSupport::Concern

  included do
    after_commit :clear_redis_cache
  end

  private

  def clear_redis_cache
    return unless Rails.cache.respond_to?(:delete_matched)

    # Clear model-specific cache
    CacheService.bust_model_cache(self.class, id)

    # Clear parent cache if applicable
    if respond_to?(:parent_id) && parent_id
      Rails.cache.delete("user_#{parent_id}_children")
      Rails.cache.delete_matched("*user_#{parent_id}*")
    end

    # Clear athlete cache if applicable
    return unless respond_to?(:athlete_id) && athlete_id

    CacheService.bust_model_cache(User, athlete_id)
    Rails.cache.delete_matched("*child_#{athlete_id}*")
  end
end
