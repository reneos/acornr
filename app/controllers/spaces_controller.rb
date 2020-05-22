class SpacesController < ApplicationController
  def index
    if params[:search]
      coords = params[:search][:coords].split('-').map(&:to_f)
      @spaces = policy_scope(Space).near(coords)
      @place = params[:search][:place]
    else
      @spaces = policy_scope(Space).geocoded
    end
    @markers = @spaces.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { space: space })
      }
    end
  end

  def show
    @space = Space.find(params[:id])
    @booking = Booking.new # For rendering the booking form
    @booking.space = @space
    authorize @space
  end

  def new
    @space = Space.new
    authorize @space
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    authorize @space
    if @space.save
      redirect_to space_path(@space), flash: {notice: "Space successfully added!" }
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:title, :description, :address, :price, :photo)
  end
end
