class BookingsController < ApplicationController
  before_action :set_space, only: [:new, :create]
  def new
    authorize @booking
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.space = @space
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to space_path(@space)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end
