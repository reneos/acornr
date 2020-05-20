class BookingsController < ApplicationController
  before_action :set_space, only: [:new, :create]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new
    @booking.message = (params[:booking][:message])
    dates = params[:booking][:start_date].gsub(' to ',' ').split(' ').map { |date| Date.parse(date) }
    @booking.start_date = dates[0]
    @booking.end_date = dates[1]
    @booking.space = @space
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to dashboard_index_path, flash: {notice: "Booking requested. Please wait for the host to respond." }
    else
      render 'spaces/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :message)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end

