require './app/helpers/application_helper'

class CommentsController < ApplicationController
  include ApplicationHelper

  def new
    unless session[:user_id]
      flash[:warning] = "You must be signed in to write a comment."
      redirect_back fallback_location: apartment_url(params[:apartment_id]) and return
    end
    @apartment = Apartment.find(params[:apartment_id])
  end

  def create
    unless validate_comment_params(comments_params) && Comment.create(comments_params)
      flash[:warning] = "Failed to comment."
      redirect_back fallback_location: apartment_url(comments_params[:apartment_id]) and return
    end
    flash[:notice] = "Commented successfully."
    redirect_to apartment_path(comments_params[:apartment_id])
  end

  def edit
    @comment = Comment.find(params[:id])
    unless session[:user_id] == @comment.user_id
      flash[:warning] = "Cannot edit a comment that is not yours."
      redirect_back fallback_location: apartment_url(params[:apartment_id]) and return
    end
    @apartment = Apartment.find(params[:apartment_id])
  end

  def update
    @comment = Comment.find params[:id]
    unless validate_comment_params(comments_params) && @comment.update(comments_params)
      flash[:warning] = "Failed to edit your comment."
      redirect_back fallback_location: apartment_url(params[:apartment_id]) and return
    end
    flash[:notice] = "Your comment was successfully updated."
    redirect_to apartment_path(@comment.apartment_id)
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

  def comments_params
    params.require(:comment).permit(:rating, :comment, :apartment_id, :user_id)
  end
end
