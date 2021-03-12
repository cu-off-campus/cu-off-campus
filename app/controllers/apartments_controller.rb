class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all
  end

  def show
    id = params[:id]
    @apartment = Apartment.find id
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  private
  def apartment_params
    params.require(:apartment).permit(:name, :price, :image, :description, :address)
  end
end
