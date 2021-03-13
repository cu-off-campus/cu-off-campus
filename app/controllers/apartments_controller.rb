require './app/helpers/application_helper'

class ApartmentsController < ApplicationController
  def index
    if params[:commit] && params[:commit] != "Filter"
      session[:sort] = ''
      flash.clear
      redirect_to and return
    end
    @apartments = Apartment.all
    @sort = params[:sort] || session[:sort]
    @price = params[:price] || session[:price]
    @search = params[:search]
    ordering = case @sort
               when 'rating'
                 { rating: :desc }
               when 'price'
                 { price: :desc }
               end
    price_range = nil
    unless @price.nil?
      price_range = {
        '0-999': [0, 999],
        '1000-1499': [1000, 1499],
        '1500-1999': [1500, 1999],
        '2000': [2000, nil]
      }[@price.to_sym]
    end
    @apartments = Apartment.filter(@search, price_range, ordering)

    flash[:notice] = "No apartment found with the filters." if @apartments.empty?
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
    @apartment = Apartment.find params[:id]
  end

  def update
    @apartment = Apartment.find params[:id]
    permitted = apartment_params
    unless ApplicationHelper.validate_aptmt_params(permitted)
      flash[:warning] = "Invalid parameters."
      redirect_to edit_apartment_path(@apartment) and return
    end
    @apartment.update_attributes!(permitted)
    flash[:notice] = "Apartment '#{@apartment.name}' was successfully updated."
    redirect_to apartment_path(@apartment)
  end

  private
  def apartment_params
    params.require(:apartment).permit(:name, :price, :image, :description, :address)
  end
end
