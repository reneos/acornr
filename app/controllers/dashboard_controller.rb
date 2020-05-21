class DashboardController < ApplicationController
  def index
    @bookings = policy_scope(current_user.bookings)
    @spaces = policy_scope(current_user.spaces)
    @bookings_as_host = policy_scope(current_user.bookings_as_host)
  end
end

# booking_as_host all the bookings other people have made on your spaces
