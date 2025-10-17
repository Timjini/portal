# frozen_string_literal: true

class Competition < ApplicationRecord

  def name
    self[:title]
  end
end
