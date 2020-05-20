class Space < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :title, :address, :description, :price, presence: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map { |d| { from: d[0], to: d[1]-1 } }
  end
end
