class CommentsController < ApplicationController
  def new
    unless session[:user_id]
      flash[:warning] = "You must be signed in to write a comment."
      redirect_back fallback_location: apartment_url(params[:apartment_id]) and return
    end
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    unless Comment.create(create_comments_params)
      flash[:warning] = "Failed to comment."
      redirect_back fallback_location: apartment_url(create_comments_params[:apartment_id]) and return
    end
    flash[:notice] = "Commented successfully."
    redirect_to apartment_path(create_comments_params[:apartment_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == session[:user_id]
      Comment.delete(params[:id])
      flash[:notice] = "Successfully deleted the comment."
    else
      flash[:warning] = "Cannot delete the comment."
    end
    redirect_back fallback_location: apartment_url(comment.apartment_id)
  end

  private

  def create_comments_params
    params.require(:comment).permit(:rating, :comment, :apartment_id, :user_id)
  end
end
