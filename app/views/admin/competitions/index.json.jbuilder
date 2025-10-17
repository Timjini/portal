# frozen_string_literal: true

json.array! @competitions, partial: 'competitions/competition', as: :competition
