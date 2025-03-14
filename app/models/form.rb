# frozen_string_literal: true

class Form < ApplicationRecord
  enum :status, { new: 'new', fulfilled: 'fulfilled', archived: 'archived' }, prefix: true
end
