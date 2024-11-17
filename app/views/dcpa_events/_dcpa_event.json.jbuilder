json.extract! dcpa_event, :id, :title, :coach, :dates, :time_start, :time_end, :location, :ages_available, :price, :dcpa_discount, :extras, :event_type, :created_at, :updated_at
json.url dcpa_event_url(dcpa_event, format: :json)
