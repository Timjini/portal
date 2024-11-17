class DcpaEventSerializer < ActiveModel::Serializer
  attributes :id, :title, :coach, :dates, :time_start, :time_end, :location, :ages_available, :price, :dcpa_discount, :extras, :event_type
end
