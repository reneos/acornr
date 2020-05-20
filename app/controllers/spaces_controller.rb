class SpacesController < ApplicationController
  def index
    @spaces = policy_scope(Space).order(created_at: :desc)
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
