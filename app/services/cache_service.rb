# frozen_string_literal: true

class CacheService
  class << self
    # Generic cache method
    def fetch(key, expires_in: 1.hour, &)
      return yield unless cache_available?

      Rails.cache.fetch(key, expires_in: expires_in, &)
    end

    # Cache with tags (requires Redis)
    def fetch_with_tags(key, tags: [], expires_in: 1.hour, &)
      return yield unless cache_available?

      Rails.cache.fetch([*tags, key].join(':'), expires_in: expires_in, &)
    end

    # Cache collections
    def cache_collection(collection, prefix:, expires_in: 1.hour)
      return collection unless cache_available?

      collection.map do |item|
        fetch("#{prefix}_#{item.id}", expires_in: expires_in) { item }
      end
    end

    # Bust cache by pattern
    def bust(pattern)
      return unless cache_available?

      if Rails.cache.respond_to?(:delete_matched)
        Rails.cache.delete_matched(pattern)
      else
        Rails.logger.warn "Cache store doesn't support delete_matched"
      end
    end

    # Bust cache for specific model
    def bust_model_cache(model_class, id)
      return unless cache_available?

      # Clear all cache keys related to this model
      bust("*#{model_class.name.underscore}_#{id}*")
      bust("*#{model_class.name.underscore}_#{id}_*")
    end

    def cache_available?
      Rails.cache.respond_to?(:read)
    end
  end
end
