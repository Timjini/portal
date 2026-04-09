# frozen_string_literal: true

class Plan < ApplicationRecord
  has_many :user_plans, dependent: :destroy
  # --- Enums ---
  # Helps map the 'status' and 'interval_unit' strings to readable scopes
  enum :status, { active: 'active', inactive: 'inactive', paused: 'paused' }, default: 'active'
  enum :interval_unit, { day: 'daily', week: 'weekly', month: 'monthly', year: 'yearly' }

  # --- Basic Validations ---
  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, format: { with: /\A[A-Z]{3}\z/ }

  # Ensure the URL is valid if present
  validates :url, :redirect_url, format: { with: URI::DEFAULT_PARSER.make_regexp },
                                 allow_blank: true

  # --- Scheduling Validations ---
  validates :interval, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :day_of_month, inclusion: { in: 1..31 }, allow_nil: true
  validates :day_of_week, inclusion: { in: 0..6 }, allow_nil: true

  # --- JSON Store Validations ---
  # Validating keys inside JSON blocks
  # validate :validate_fx_structure
  # validate :validate_links_presence

  # private

  # def validate_fx_structure
  #   return if fx.blank?

  #   unless fx.key?('exchange_rate') && fx.key?('fx_currency')
  #     errors.add(:fx, 'must contain exchange_rate and fx_currency keys')
  #   end

  #   return unless fx['exchange_rate'].present? && !fx['exchange_rate'].is_a?(Numeric)

  #   errors.add(:fx, 'exchange_rate must be a number')
  # end

  # def validate_links_presence
  #   return unless links.blank? || links['organisation'].blank?

  #   errors.add(:links, 'must include an organisation reference')
  # end

  def amount_string
    amount.to_i.to_s
  end
end
