class JsonSizeLimiter
  def initialize(json, max_size: 1000)
    @json = json
    @max_size = max_size
    @truncated = false
    @truncated_json = nil
    @truncated_size = nil
    @original_size = nil
    @truncated_message = nil
    @truncated_backtrace = nil
    @truncated_context = nil
    @truncated_error_type = nil
    @truncated_occurred_at = nil
    @truncated_error = nil
    @truncated_error_message = nil
    @truncated_error_backtrace = nil
    @truncated_error_context = nil
    
end