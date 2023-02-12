class Public::FavoritesController < ApplicationController
  def create
    posting = Posting.find(params[:posting_id])
    favorite = current_customer.favorites.new(posting_id: posting.id)
    favorite.save
    redirect_to public_posting_path(posting)
  end

  def destroy
    posting = Posting.find(params[:posting_id])
    favorite = current_customer.favorites.find_by(posting_id: posting.id)
    favorite.destroy
    redirect_to public_posting_path(posting)
  end
end
