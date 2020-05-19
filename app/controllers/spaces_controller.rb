class SpacesController < ApplicationController
  def index
    @spaces = Space.all
  end

  def show
    @space = Space.find(params[:id])
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      redirect_to @space, notice: 'Space was successfully created.'
    else
      render :new
    end
  end

  private

  def space_params
    params.require(:space).permit(:title, :description, :address)
  end
end
