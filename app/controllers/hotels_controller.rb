class HotelsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @hotels = Hotel.all
    else
      @sorted_hotels = Hotel.sort_hotels
    end
  end

  def show
    @hotel = Hotel.find(params[:id])
    @comment = Comment.new
  end

  def new
    @hotel = Hotel.new
    @hotel.address = Address.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user
    @hotel.breakfast_in = true if params[:hotel][:breakfast_in] == 'Yes'

    if @hotel.save
      redirect_to hotel_path(@hotel)
    else
      render 'new'
    end
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to hotels_path
  end

  private
  def hotel_params
    params.require(:hotel).permit(:title, :hotel_image, :rating, :breakfast_in, :room_description, :price,
      address_attributes: [:country, :state, :city, :street])
  end
end
