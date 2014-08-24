class CommentsController < ApplicationController
  def create
    hotel = Hotel.find(params[:hotel_id])
    @comment = Comment.new(comment_params)
    @comment.hotel = hotel
    @comment.user_name = current_user.email
    flash[:notice] = 'Comment successfully created' if @comment.save
    redirect_to hotel_path(hotel)
  end

  private
  def comment_params
    params.require(:comment).permit(:rating, :body)
  end
end
