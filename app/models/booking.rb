class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user

  validates :start_date, :end_date, :message, presence: true
  validate :dates_valid
  validate :availability

  after_validation :update_price
  def update_price
    self.price = (end_date - start_date).to_i * space.price
  end

  private


  def dates_valid
    return unless start_date && end_date
    errors.add(:end_date, "start date must be before end date") if end_date <= start_date
  end

   def availability
    # exclude end date in range because you can start on the same day another booking ends
    other_bookings_ranges = space.bookings.reject { |b| b == self }.map { |b| (b.start_date...b.end_date) }
    if other_bookings_ranges.any? { |range| range.overlaps?(start_date...end_date) }
      errors.add(:start_date, "dates overlap with another booking")
    end
  end

end
