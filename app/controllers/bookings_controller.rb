class BookingsController < ApplicationController
  before_action :set_space, only: [:new, :create]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.space = @space
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to dashboard_index_path, flash: {notice: "Booking requested. Please wait for the host to respond." }
    else
      render 'spaces/show'
    end
  end

  def update
    @booking = Booking.find(params[:id])

    if params[:booking][:approved]
      @booking.approved = true
    elsif params[:booking][:rejected]
      @booking.rejected = true
    end
    authorize @booking
    @booking.save
    message = "You have #{@booking.approved ? "accepted" : "declined" } the booking for #{@booking.space.title.downcase}"
    redirect_to dashboard_index_path, flash: { notice: message }
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :message)
  end

  def set_space
    @space = Space.find(params[:space_id])
  end
end

