class HotelsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index

    if user_signed_in?
      @hotels = Hotel.all
    else
      @hotels = 'Top 5 hotels'
    end

  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  def new
    @hotel = Hotel.new
    @hotel.address = Address.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user

    if @hotel.save
      redirect_to hotel_path(@hotel)
    else
      redirect_to new_hotel_path
    end
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to hotels_path
  end

  private
  def hotel_params
    params.require(:hotel).permit(:title, :rating, :breakfast_in, :room_description, :price,
      address_attributes: [:country, :state, :city, :street])
  end
end
