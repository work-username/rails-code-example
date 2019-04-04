class Event < ActiveRecord::Base
  validates :title, :starts_at, :ends_at, presence: true
  validate :date_range_correct?

  scope :starts_before, ->(date) { date.is_a?(DateTime) ? where('starts_at <= ?', date) : self }
  scope :ends_after, ->(date) { date.is_a?(DateTime) ? where('ends_at >= ?', date) : self }

  def date_range_correct?
    return if starts_at.blank? || ends_at.blank?
    return if starts_at < ends_at

    errors[:base] << 'The start date should be less or equal than the end date'
  end
end
