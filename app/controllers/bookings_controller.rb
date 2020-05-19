class BookingsController < ApplicationController
  before_action :set_space, only: [:new, :create]
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.space = @space
    if @booking.save
      redirect_to space_path(@space)
    else
      render 'bookings/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :user, :space)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end
