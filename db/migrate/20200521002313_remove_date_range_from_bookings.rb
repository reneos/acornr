class RemoveDateRangeFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :date_range, :string
  end
end
