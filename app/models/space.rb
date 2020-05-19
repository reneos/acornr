class Space < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :title, :address, :description, presence: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map { |d| { from: d[0], to: d[1]-1 } }
  end
end
