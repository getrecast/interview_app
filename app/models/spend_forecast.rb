class SpendForecast < ApplicationRecord
  STATUSES = %w[draft in_progress completed].freeze

  validates :name, presence: true, unless: :draft?
  validates :start_date, presence: true, unless: :draft?
  validates :end_date, presence: true, unless: :draft?
  validates :budget, presence: true, unless: :draft?
  validates :status, presence: true, inclusion: { in: STATUSES }

  attr_accessor :budget_file

  enum status: STATUSES.index_by(&:to_sym)

  belongs_to :user
end
