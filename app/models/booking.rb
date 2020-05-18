class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user

  validates :start_date, :end_date, presence: true
  validate :dates_valid

  private
  def dates_valid
    return unless start_date && end_date
    errors.add(:end_date, "start date must be before end date") if end_date <= start_date
  end
end
