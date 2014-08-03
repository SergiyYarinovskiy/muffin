class HotelsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @hotels = Hotel.all
    else
      @sor_hotels = []
      Hotel.all.each do |hotel|
        @sor_hotels << { title: hotel.title,
          average_rating: (hotel.comments.sum(:rating) + hotel.rating)/(hotel.comments.count + 1)}
      end
      @sor_hotels.sort_by! { |elem| elem[:average_rating] }.reverse!
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

  def create_comment
    hotel = Hotel.find(params[:format])
    @comment = Comment.new(hotel: hotel, user_name: current_user.email,
      rating: params[:comment][:rating], body: params[:comment][:body])
    @comment.save
    redirect_to hotel_path(hotel)
  end

  private
  def hotel_params
    params.require(:hotel).permit(:title, :hotel_image, :rating, :breakfast_in, :room_description, :price,
      address_attributes: [:country, :state, :city, :street])
  end
end
