# frozen_string_literal: true

json.array! @athlete_level_categories, partial: 'athlete_level_categories/athlete_level_category',
                                       as: :athlete_level_category
