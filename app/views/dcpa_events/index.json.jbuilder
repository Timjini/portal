# frozen_string_literal: true

json.array! @dcpa_events, partial: 'dcpa_events/dcpa_event', as: :dcpa_event
