class AddRejectedToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :rejected, :boolean, default: false
  end
end
